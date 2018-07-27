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
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(123131, 123123)
    
    var mealID: Int = 0
    var hawkerCentres : [HawkerCentres] = []
    var hawkerCenteresWithMeal : [HawkerCentres] = []
    var meal: Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hawkerMapView.delegate = self
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 100)
        loadAllHawkers()
        loadOneMeal()
        
        checkForHawker.loadHawkerWithMeal(meal: meal, hawkers: hawkerCentres)
        if (hawkerSegment.selectedSegmentIndex == 0) {
            loadPointersWithMeal()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segment changed
    @IBAction func segmentChanged(_ sender: Any) {
        hawkerMapView.removeAnnotation(hawkerMapView.annotations as! MKAnnotation)
        if (hawkerSegment.selectedSegmentIndex == 0 ){
            loadPointersWithMeal()
        }
        else {
            loadAllPointers()
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    // MARK: - Functions
    func loadAllHawkers(){
        DietaryPlanDataManagerFirebase.loadHawkerCentres(){
            hawkerFromFirebase in
            self.hawkerCentres = hawkerFromFirebase
        }
    }
    
    func loadOneMeal(){
        DietaryPlanDataManagerFirebase.loadOneMeal(id: mealID){
            mealFromFirebase in
            self.meal = mealFromFirebase
        }
    }
    
    func updateMapRegion(rangeSpan: CLLocationDistance){
        let region = MKCoordinateRegionMakeWithDistance(coordinate2D, rangeSpan, rangeSpan)
        hawkerMapView.region = region
    }
    
    func loadPointersWithMeal(){
        for i in 0...self.hawkerCenteresWithMeal.count - 1
        {
            let p = MKPointAnnotation()
            p.coordinate = CLLocationCoordinate2D(latitude: self.hawkerCenteresWithMeal[i].latitude!, longitude: self.hawkerCenteresWithMeal[i].longitude!)
            p.title = self.hawkerCenteresWithMeal[i].hawkerName
            p.subtitle = self.hawkerCenteresWithMeal[i].address
            self.hawkerMapView.addAnnotation(p)
        }
    }
    
    func loadAllPointers(){
        for i in 0...self.hawkerCentres.count - 1
        {
            let p = MKPointAnnotation()
            p.coordinate = CLLocationCoordinate2D(latitude: self.hawkerCentres[i].latitude!, longitude: self.hawkerCentres[i].longitude!)
            p.title = self.hawkerCentres[i].hawkerName
            p.subtitle = self.hawkerCentres[i].address
            self.hawkerMapView.addAnnotation(p)
        }
    }
}
