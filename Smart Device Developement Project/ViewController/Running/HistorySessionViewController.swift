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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedID : Int = Int(currentid)!
        var selectedSession = RunningDataManager.loadSessionByID(selectedID)
        var selectSessionMap = RunningDataManager.loadSessionlocationByID(selectedID)
        let longitude = selectSessionMap.rangeoflongitude?.components(separatedBy: ",")
        let latitude = selectSessionMap.rangeoflatitude?.components(separatedBy: ",")
        
        for i in 0 ..< longitude!.count
            {
                let coordinate:CLLocation = CLLocation(latitude: Double(latitude![i])!, longitude: Double(longitude![i])!)
        }
        lblTotalTime.text = selectedSession.totaltime
        lblTotalDistance.text = String(format: "%.2f",selectedSession.totaldistance!)
        lblTotalCaloriesBurnt.text = String(format: "%.2f", selectedSession.totalcaloriesburnt!)
        lblavgspeed.text = String(format: "%.2f", selectedSession.totalspeed!)
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
