//
//  RunningTimerViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit

class RunningTimerViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 100)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findHere(_ sender: UIButton)
    {
        setupCoreLocation()
    }
    // Mark:Instance Methods
    func updateMapRegion(rangeSpan:CLLocationDistance){
        let region = MKCoordinateRegionMakeWithDistance(coordinate2D, rangeSpan, rangeSpan)
        mapView.region = region
    }
    
    
    // Mark:Location
    func setupCoreLocation(){
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            enableLocationServices()
        default:
            break
        }
        
    }
    
    func enableLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
        locationManager.startUpdatingLocation()
        mapView.setUserTrackingMode(.follow, animated: true)
        }
    }
    
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
        
    }
    //Mark: Location Manager delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedAlways:
            print("authorized")
        case .denied, .restricted:
            print("not authorized")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        	let location = locations.last!
            coordinate2D = location.coordinate
            let displayString = "(\(location.timestamp) Coord:\(coordinate2D)"
            print(displayString)
            updateMapRegion(rangeSpan: 200)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
