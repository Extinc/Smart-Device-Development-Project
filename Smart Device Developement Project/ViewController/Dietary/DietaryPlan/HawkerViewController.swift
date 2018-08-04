//
//  HawkerViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit

class HawkerViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: - Outlets
    @IBOutlet var hawkerSegment: UISegmentedControl!
    @IBOutlet weak var hawkerMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(1.3800709, 103.8490213)
    
    var hawkerCentres : [HawkerCentres] = []
    var hawkerCenteresWithMeal : [HawkerCentres] = []
    var meal: Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hawkerMapView.delegate = self
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 750)
        
        let nyp = MKPointAnnotation()
        nyp.title = "Nanyang Polytechnic"
        nyp.coordinate = coordinate2D
        hawkerMapView.addAnnotation(nyp)
        
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
        //hawkerMapView.removeAnnotation(hawkerMapView.annotations as! MKAnnotation)
        if (hawkerSegment.selectedSegmentIndex == 0 ){
            loadPointersWithMeal()
        }
        else if(hawkerSegment.selectedSegmentIndex == 1){
            loadAllPointers()
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Annotation Delegates
    
    // MARK: - Functions
    
    func updateMapRegion(rangeSpan: CLLocationDistance){
        let region = MKCoordinateRegionMakeWithDistance(coordinate2D, rangeSpan, rangeSpan)
        hawkerMapView.region = region
    }
    
    func loadPointersWithMeal(){
        for i in 0...self.hawkerCenteresWithMeal.count - 1
        {
            let p = MKPointAnnotation()
            p.coordinate = CLLocationCoordinate2DMake(self.hawkerCenteresWithMeal[i].latitude!, self.hawkerCenteresWithMeal[i].longitude!)
            p.title = self.hawkerCenteresWithMeal[i].hawkerName
            p.subtitle = self.hawkerCenteresWithMeal[i].address
            hawkerMapView.addAnnotation(p)
        }
        
    }
    
    func loadAllPointers(){
        for i in 0...self.hawkerCentres.count - 1
        {
            let p = MKPointAnnotation()
            p.coordinate = CLLocationCoordinate2DMake(self.hawkerCentres[i].latitude!, self.hawkerCentres[i].longitude!)
            p.title = self.hawkerCentres[i].hawkerName
            p.subtitle = self.hawkerCentres[i].address
            hawkerMapView.addAnnotation(p)
        }
    }
    
  
}

extension HawkerViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if let title = annotation.title, title == "Nanyang Polytechnic" {
            
        }
        else {
            annotationView?.image = UIImage(named: "markersmall")
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected: \(view.annotation?.title)")
    }
}
