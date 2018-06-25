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
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblProgress: UILabel!
    
    @IBOutlet weak var lblNumberofProgress: UILabel!
    
    @IBOutlet weak var btncontinue: UIButton!
    
    @IBOutlet weak var buttonPause: UIButton!
    
    @IBOutlet weak var lblCalories: UILabel!
    
    var mylocations: [CLLocation] = []
    var targetDistance: Double = 0
    var startDate: Date!
    var startlocation: CLLocation!
    var lastLocation: CLLocation!
    var travelledDistance: Double = 0
    var time : Double = 0
    var calorie : Double = 0
    var weight : Double = 60
    var resumeTapped = false
    var seconds = 60
    
    @IBOutlet weak var lblspeed: UILabel!
    //timer
    weak var timer = Timer()
    
    @IBAction func btnPause(_ sender: Any) {
        if self.resumeTapped == false
        {
        timer!.invalidate()
        self.resumeTapped = true
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        disableLocationServices()
        buttonPause.isHidden = true
        btncontinue.isHidden = false
        mapView.setUserTrackingMode(.follow, animated: true)
        }
        
       
     /*   if(timer!.isValid == false)
        {
            buttonPause.isHidden = false
            btncontinue.isHidden = true
        }
        else
        {
            buttonPause.isHidden = true
            btncontinue.isHidden = false
        }
 */
    }
    
  var username = "john"
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        btncontinue.isHidden = true
        buttonPause.isHidden = true
        mapView.delegate = self
        //Create Database When entered this page
        RunningDataManager.createScheduleTable()
        RunningDataManager.createSessionTable()
        
        //Ask permission to access user location but do not start first
        setupCoreLocation()
        disableLocationServices()
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 100)
        
        //If there is an ongoing schedule, retrieve ongoing schedule information to remind user that there is one else inform them there is no schedule
        if(RunningDataManager.checkUserScheduleExist(username) == true)
        {
            let currentschedule = RunningDataManager.loadScheduleInformation(username)
            let title : String = currentschedule.trainingdistance!
            let progress : String = currentschedule.progress!
            let totalTime : String = currentschedule.numberoftimes!
            lblProgress.text = "\(title)Km Run/Jog"
            lblNumberofProgress.text = "\(progress) / \(totalTime) Times "
        }
        else{
            lblNumberofProgress.text = "No Schedule Created"
        }
        
     
        // Do any additional setup after loading the view.
        RunningDataManager.createScheduleTable()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Start Timer

    @IBAction func start(_ sender: UIButton) {
        setupCoreLocation()
        //Creating Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RunningTimerViewController.action), userInfo: nil, repeats: true)
        //Hide redundant data
        if(timer!.isValid == true)
        {
            btnStart.isHidden = true
            lblProgress.isHidden = true
            lblNumberofProgress.isHidden = true
            buttonPause.isHidden = false
        }
        
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        if self.resumeTapped == true{
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RunningTimerViewController.action), userInfo: nil, repeats: true)
            enableLocationServices()
            self.resumeTapped = false
            buttonPause.isHidden = false
            btncontinue.isHidden = true
        
        
        
        }
        
        
    }
    

      @objc func action()
    {
      time += 1
        lblTime.text = timeString(time: (TimeInterval(time)))
    
    }
    
    //Pause Timer
    
    
 
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 10
        mapView.setUserTrackingMode(.follow, animated: true)
        }
    }
    
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
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
            mylocations.append(locations[0] as CLLocation)
            coordinate2D = location.coordinate
            let displayString = "(\(location.timestamp) Coord:\(coordinate2D)"
            print(displayString)
            updateMapRegion(rangeSpan: 200)
        
        if(btncontinue.isHidden == false || btnStart.isHidden == false)
        {
            startlocation = nil
        }
        
        if startDate == nil{
            startDate = Date()
        } else {
            print("elapsedTime :", String(format: "%.0fs",Date().timeIntervalSince(startDate)))
        }
        if startlocation == nil{
            startlocation = locations.first
        }
        else if let location = locations.last{
          
        
            travelledDistance += lastLocation.distance(from: location)
       
            // Convert Meter to KiloMeters
            var distanceInkiloMeter = travelledDistance/1000
            
            
            calorie = distanceInkiloMeter * weight * 1.036
            var calorieString = String(calorie)
            
            print("Traveled Distance:", travelledDistance)
            print("Straight Distance:", startlocation.distance(from: locations.last!))
            self.lblDistance.text! = String(format : "%.2f",distanceInkiloMeter) + " Km "
            self.lblCalories.text! = String(format : "%.2f",calorie) + " cal"
            
        }
            lastLocation = locations.last
        
            var speed = travelledDistance/time
        //Convert time to meter/second
        self.lblspeed.text = String(format :"%.2f",speed) + " m/s"
        
        
        
        if(mylocations.count > 1)
        {
            var sourceIndex = mylocations.count - 1
            var destinationIndex = mylocations.count - 2
            
            let c1 = mylocations[sourceIndex].coordinate
            let c2 = mylocations[destinationIndex].coordinate
            var a = [c1,c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.add(polyline)
        }
 
        
       
        
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
    
    func timeString(time:TimeInterval) -> String{
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hour, minute, second)
    }
    
    
    
   
 


 /*   func addAnnotationsOnMap(locationToPoint: CLLocation)
    {
        var annotation = MKPointAnnotation()
        annotation.coordinate = locationToPoint.coordinate
        var geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locationToPoint, completionHandler:{(placemarks, Error) -> Void in
        if let placemarks = placemarks as? [CLPlacemark] where placemarks.count > 0 {
            var placemark = placemarks[0]
            var addressDictionary = placemarks.addressDictionary;
            annotation.title = addressDictionary["Name"] as? String
            self.mapView.addAnnotation(annotation)
            }
        })
    }
 */
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if  (error as? CLError)?.code == .denied{
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
    }
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
