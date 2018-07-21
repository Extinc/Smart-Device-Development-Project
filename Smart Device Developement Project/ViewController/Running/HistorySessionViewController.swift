//
//  HistorySessionViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit


class HistorySessionViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

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
  

        for i in 0 ..< longitude.count {
      //this loop got error
         var sourceIndex = i
        
            
            for j in 1 ..< longitude.count {
            
             destinationIndex = j
            }
            
            let c1 = mylocations[sourceIndex].coordinate
            let c2 = mylocations[destinationIndex].coordinate
            var a = [c1,c2]
            print("\(a)")
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            historyMap.add(polyline)
            
        }
        lblTotalTime.text = selectedSession.totaltime
        lblTotalDistance.text = String(format: "%.2f",selectedSession.totaldistance!)
        lblTotalCaloriesBurnt.text = String(format: "%.2f", selectedSession.totalcaloriesburnt!)
        lblavgspeed.text = String(format: "%.2f", selectedSession.totalspeed!)
        
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
