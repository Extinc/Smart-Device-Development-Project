//
//  HistorySessionViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit


class HistorySessionViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource{
    
     let data: [String] = ["item1","item2","item3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
   
    


    @IBOutlet weak var historyMap: MKMapView!
    
    @IBOutlet weak var btnAverageSpeed: UIButton!
    
    
    @IBOutlet weak var lblavgspeed: UILabel!
    
    @IBOutlet weak var lblTotalTime: UILabel!
    
    @IBOutlet weak var lblTotalDistance: UILabel!
    
    @IBOutlet weak var lblTotalCaloriesBurnt: UILabel!
    
    var currentid = String()
    
    var mylocations: [CLLocation] = []
    
    var sourceIndex = 1
    var destinationIndex = 1
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(37.32460617, -122.02447971 )
    struct Objects {
        var sectionName : String!
        var sectionObject: [String]!
    }
    
    var objectArray = [Objects]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var selectedID : Int = Int(currentid)!
        print("Selecte ID \(selectedID)")
      
        var selectedSession = RunningDataManager.loadSessionByID(selectedID)
        var selectSessionMap = RunningDataManager.loadSessionlocationByID(selectedID)
        let longitude = selectSessionMap.rangeoflongitude!.components(separatedBy: ",")
        let latitude = selectSessionMap.rangeoflatitude!.components(separatedBy: ",")
       for i in 0 ..< longitude.count
            {
                print("longitude = \(longitude[i]) latitude =\(latitude[i])")
                let coordinate:CLLocation = CLLocation(latitude: Double(latitude[i])!, longitude: Double(longitude[i])!)
                
                mylocations.append(coordinate)
                
        }
  

        for i in 0 ..< longitude.count - 1 {
      //this loop got error
         var sourceIndex = i
    
            destinationIndex = i + 1;
            let c1 = mylocations[sourceIndex].coordinate
            let c2 = mylocations[destinationIndex].coordinate
            var a = [c1,c2]
            print("\(a)")
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            historyMap.add(polyline)
            
        }
        lblTotalTime.text = selectedSession.totaltime
         var time = selectedSession.totaltime
        var distance = String(format: "%.2f",selectedSession.totaldistance!)
        var calories = String(format: "%.2f", selectedSession.totalcaloriesburnt!)
        var speed =  String(format: "%.2f", selectedSession.totalspeed!)
        lblTotalDistance.text = String(format: "%.2f",selectedSession.totaldistance!)
        lblTotalCaloriesBurnt.text = String(format: "%.2f", selectedSession.totalcaloriesburnt!)
        lblavgspeed.text = String(format: "%.2f", selectedSession.totalspeed!)
        
        
        
   /*
         Not done yet
         objectArray = [Objects(sectionName: "Time", sectionObject: ["Time taken :\(time)"]),Objects(sectionName: "Distance", sectionObject: ["Distance ran :\(distance)"]),Objects(sectionName: "Calories", sectionObject: ["Calories Burnt :\(calories)"]),Objects(sectionName: "Speed", sectionObject: ["Average speed:\(speed)"])]
 */
        
        
        
        historyMap.delegate = self
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 1000)
 
       
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        if overlay is MKPolyline{
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.black
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func updateMapRegion(rangeSpan:CLLocationDistance){
        var selectedID : Int = Int(currentid)!
        print("Selecte ID \(selectedID)")
        
      

        let region = MKCoordinateRegionMakeWithDistance(mylocations[0].coordinate, rangeSpan, rangeSpan)
         historyMap.region = region
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
