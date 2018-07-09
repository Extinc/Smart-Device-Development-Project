//
//  WeatherService.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 9/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate{
    func setWeather(weather: Weather)
}
class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeatherForCity(lat: String, lon: String){
        
        let latitude = lat.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let longitude = lon.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        
        let path = "https://samples.openweathermap.org/data/2.5/weather?lat=\(latitude!)&lon=\(longitude!)&appid=b6907d289e10d714a6e88b30761fae22"
        let url = URL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with: url!){(data: Data?, response: URLResponse? , error: Error?) -> Void in
                print("\(data)")
            let json = JSON(data:data!)
            let lon =  json["coord"]["lon"].double
            let lat =  json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            
            let weather = Weather(cityName: name!, temp: temp!, description: desc!)
            
            if self.delegate != nil {
                self.delegate?.setWeather(weather: weather)
            }
            print("Lat: \(lat!) lon: \(lon!) temp: \(temp!)")
        }
        task.resume()
     
    }
}

