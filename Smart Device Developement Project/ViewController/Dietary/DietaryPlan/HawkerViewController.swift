//
//  HawkerViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit

class HawkerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: - Outlets
    @IBOutlet var hawkerSegment: UISegmentedControl!
    @IBOutlet weak var hawkerMapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var hawkerCentres : [HawkerCentres] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hawkerMapView.delegate = self
        locationManager.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Functions
    
    func loadPointers(){
        for i in 0...self.hawkerCentres.count - 1
        {
            let p = MKPointAnnotation()
            p.coordinate = CLLocationCoordinate2D(latitude: self.hawkerCentres[i].latitude!, longitude: self.hawkerCentres[i].longitude!)
            p.title = self.hawkerCentres[i].hawkerName
            self.hawkerMapView.addAnnotation(p)
        }
    }
}
