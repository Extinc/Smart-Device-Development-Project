//
//  RunningTimerViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//
// THIS VERSION EDITUR CONSTRUCTOR COZ U ADD 1 MORE COLUMN IN DB TOTALTIME COLUMN
import UIKit
import MapKit
import AVFoundation
import CoreData


class RunningTimerViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, WeatherServiceDelegate,UIScrollViewDelegate{
    
    var audioPlayer = AVAudioPlayer()
    var synth = AVSpeechSynthesizer()
    var ZombieWarning = AVSpeechUtterance(string: "")
    var ZombieSafe = AVSpeechUtterance(string: "")
    var ZombieDangerous = AVSpeechUtterance(string: "")
    var ZombieNotTooDangerous = AVSpeechUtterance(string: "")
    var DistanceNotification = AVSpeechUtterance(string: "")
    var authUID = AuthenticateUser.getUID()
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var lblprogress: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    
    @IBOutlet weak var templbl: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var btnViewAddTask: UIButton!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblProgress: UILabel!
    
    @IBOutlet weak var lblNumberofProgress: UILabel!
    
    @IBOutlet weak var btncontinue: UIButton!
    
    @IBOutlet weak var buttonPause: UIButton!
    
    @IBOutlet weak var lblCalories: UILabel!
    
    @IBOutlet weak var btnComplete: UIButton!
    
    @IBOutlet weak var btnCreateSchedules: UIButton!
    
    @IBOutlet weak var ZombieModeSwitch: UISwitch!
    
    @IBOutlet weak var lblZombie: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var forfeitedcount: UILabel!
    
    @IBOutlet weak var completecount: UILabel!
    
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
    var scheduleid = 0
    var thisprogress = 0
    var progress : String = ""
    var lap1Speed : String = ""
    var lap2Speed : String = ""
    var lap3Speed : String = ""
    var lap4Speed : String = ""
    var lap5Speed : String  = ""
    var lap1distance : Double = 0
    var lap2distance : Double = 0
    var lap3distance : Double = 0
    var lap4distance : Double = 0
    var lap5distance : Double = 0
    var zombiespeed : Double = 30.0
    var zombietime : Double = 0
    var zombiedistance : Double = 0
    var lap1time : Double = 0
    var lap2time : Double = 0
    var lap3time : Double = 0
    var lap4time : Double = 0
    var lap5time : Double = 0
    var ZombieDangerousshortimer : Double = 0
    var ZombieNotTooDangerousTime : Double = 0
    var ZombieSafeTimer = 0
    var lastSessionID = 0
    var lapdistance: Double = 0
    var callfirst : Int = 1
    var callsecond : Int = 1
    var callthird : Int = 1
    var callfourth : Int = 1
    var callfifth : Int = 1
    var latitude : String = ""
    var longitude : String = ""
    
    var noofcomplete : Int = 0
    var noofforfeit : Int = 0
    
    @IBOutlet weak var iconcross: UIImageView!
    @IBOutlet weak var icontick: UIImageView!
    
    @IBOutlet weak var Measure1view: UIStackView!
    
    @IBOutlet weak var measure2view: UIStackView!
    
    @IBOutlet weak var WeatherViewBeforeStart: UIView!
    
    @IBOutlet weak var InstructionView: UIView!
    
    @IBOutlet weak var lblspeed: UILabel!
    
    @IBOutlet weak var imagescrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var BackProgress: UIView!
    
    var runningimage: [String] = ["running1","running2","running3"]
    var frame = CGRect(x:0,y:0,width:0,height:0)
    //timer
    weak var timer = Timer()
    //Mark Weather Service
    func setWeather(weather: Weather) {
        print("set Weather")
        print("City \(weather.cityName) temp\(weather.temp) desc: \(weather.description)")
        var kelvin : Double = Double(weather.temp)
        var celsius : Double = kelvin - 273.15
        var stringcelsius = String(celsius)
        DispatchQueue.main.async {
        self.templbl.text = "\(stringcelsius)" + " ℃"
        self.desclbl.text = weather.description
        self.weatherIcon.image = UIImage(named: weather.icon)
        }
        
    }
    
    
    
    @IBAction func btnPause(_ sender: Any) {
        if self.resumeTapped == false
        {
        timer!.invalidate()
        var thiscurrentdistance = Session(sessionid: RunningDataManager.selectlastSessionTableId(),currentdistance: travelledDistance/1000)
        RunningDataManager.UpdateCurrentDistance(session: thiscurrentdistance)
        self.resumeTapped = true
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        disableLocationServices()
        buttonPause.isHidden = true
        btncontinue.isHidden = false
        mapView.setUserTrackingMode(.follow, animated: true)
        }
        
    }
    
    var username : String = AuthenticateUser.getUID()
    
    var locationManager = CLLocationManager()
    var coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func FinishedCurrentSchedule()
    {
        var currentSchedule = RunningDataManager.loadScheduleInformation(username)
        if(currentSchedule.progress == currentSchedule.numberoftimes)
        {
            RunningDataManager.UpdateComplete(currentSchedule.scheduleId!)
            if(RunningDataManager.checkUserScheduleFinished(currentSchedule.scheduleId!) == true)
            {
                FinishAlert(title: "Successful Completed Schedule", message: "Congratulation, you have cleared your schedule , time to create a new schedule!")
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        //Get Weather
        btnViewAddTask.layer.borderWidth = 1
        btnViewAddTask.layer.borderColor = UIColor.yellow.cgColor
        noofcomplete = RunningDataManager.checkUserScheduleComplete(username)
        completecount.text = String(noofcomplete)
        noofforfeit = RunningDataManager.checkUserScheduleforfeit(username)
        forfeitedcount.text = String(noofforfeit)
       NutrInfo().getWeight(){
            weight in
            self.weight = weight
            
        }
        pageControl.numberOfPages = runningimage.count
        for index in 0..<runningimage.count{
            frame.origin.x = imagescrollView.frame.size.width * CGFloat(index)
            frame.size = imagescrollView.frame.size
            
            let imgView = UIImageView(frame : frame)
            imgView.image = UIImage(named: runningimage[index])
            self.imagescrollView.addSubview(imgView)
            
        }
        imagescrollView.contentSize = CGSize(width:(imagescrollView.frame.size.width * CGFloat(runningimage.count)), height: imagescrollView.frame.size.height)
        imagescrollView.delegate = self
 
      
       
        do{
        audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ZombieChase", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        super.viewDidLoad()
        
        mapView.isHidden = true
        
        
        self.weatherService.delegate = self
        self.weatherService.getWeatherForCity(lat: "1.3521", lon :"103.8198")

        btnComplete.isHidden = true
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        print(RunningDataManager.selectlastScheduleTableId(username))
        if(RunningDataManager.checkUserScheduleExist(username) == false)
        {
            btnCreateSchedules.isHidden = false
            mapView.isHidden = true
            btnStart.isHidden = true
            btncontinue.isHidden = true
            buttonPause.isHidden = true
            Measure1view.isHidden = true
            measure2view.isHidden = true
            InstructionView.isHidden = false
            imagescrollView.isHidden = false
            pageControl.isHidden = false
            BackProgress.isHidden = true
           
           
           
            
        }
        else
        {
        btncontinue.isHidden = true
        buttonPause.isHidden = true
        btnStart.isHidden = false
        btnCreateSchedules.isHidden = true
        mapView.isHidden = true
        Measure1view.isHidden = true
        measure2view.isHidden = true
        pageControl.isHidden = true
        imagescrollView.isHidden = true
        InstructionView.isHidden = true
        BackProgress.isHidden = false
            
        

        }
        mapView.delegate = self
        //Create Database When entered this page
        RunningDataManager.createScheduleTable()
        RunningDataManager.createSessionTable()

        //Ask permission to access user location but do not start first
    

        // need this for polyline
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 100)
        
        //If there is an ongoing schedule, retrieve ongoing schedule information to remind user that there is one else inform them there is no schedule
        if(RunningDataManager.checkUserScheduleExist(username) == true)
        {
            let currentschedule = RunningDataManager.loadScheduleInformation(username)
            scheduleid = currentschedule.scheduleId!
            thisprogress = Int(currentschedule.progress!)!
            let title : String = currentschedule.trainingdistance!
            targetDistance = Double(title)!
            progress = currentschedule.progress!
            let totalTime : String = currentschedule.numberoftimes!
            lblProgress.text = "\(title) Km Run"
            lblNumberofProgress.text = "\(progress) / \(totalTime) Completed "
        }
        else{
            lblNumberofProgress.text = "No Schedule Created"
        }
        
        lastSessionID = RunningDataManager.selectlastSessionTableId() - 1
        
        
        

        // Do any additional setup after loading the view.
        RunningDataManager.createScheduleTable()

    }
    override func viewWillAppear(_ animated: Bool) {
        noofcomplete = RunningDataManager.checkUserScheduleComplete(username)
        completecount.text = String(noofcomplete)
        noofforfeit = RunningDataManager.checkUserScheduleforfeit(username)
        forfeitedcount.text = String(noofforfeit)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ZombieChase", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        super.viewDidLoad()
        btnComplete.isHidden = true
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        print(RunningDataManager.selectlastScheduleTableId(username))
        if(RunningDataManager.checkUserScheduleExist(username) == false)
        {
            btnCreateSchedules.isHidden = false
            btnStart.isHidden = true
            btncontinue.isHidden = true
            buttonPause.isHidden = true
            Measure1view.isHidden = true
            measure2view.isHidden = true
            lblProgress.isHidden = true
            lblNumberofProgress.isHidden = true
            WeatherViewBeforeStart.isHidden = false
            InstructionView.isHidden = false
            imagescrollView.isHidden = false
            pageControl.isHidden = false
            BackProgress.isHidden = true
            lblprogress.isHidden = true

        }
        else
        {
            lblprogress.isHidden = false
            btncontinue.isHidden = true
            buttonPause.isHidden = true
            btnStart.isHidden = false
            btnCreateSchedules.isHidden = true
            Measure1view.isHidden = true
            measure2view.isHidden = true
            mapView.isHidden = true
            lblProgress.isHidden = false
            lblNumberofProgress.isHidden = false
            WeatherViewBeforeStart.isHidden = false
            InstructionView.isHidden = true
            imagescrollView.isHidden = true
            pageControl.isHidden = true
            BackProgress.isHidden = false
        }
        mapView.delegate = self
        //Create Database When entered this page
        RunningDataManager.createScheduleTable()
        RunningDataManager.createSessionTable()
        
        //Ask permission to access user location but do not start first
        
        
        // need this for polyline
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 100)
        
        //If there is an ongoing schedule, retrieve ongoing schedule information to remind user that there is one else inform them there is no schedule
        if(RunningDataManager.checkUserScheduleExist(username) == true)
        {
            let currentschedule = RunningDataManager.loadScheduleInformation(username)
            scheduleid = currentschedule.scheduleId!
            thisprogress = Int(currentschedule.progress!)!
            let title : String = currentschedule.trainingdistance!
            targetDistance = Double(title)!
            progress = currentschedule.progress!
            let totalTime : String = currentschedule.numberoftimes!
             lblProgress.text = "\(title) Km Run"
            lblNumberofProgress.text = "\(progress) / \(totalTime) Completed "
        }
        else{
            lblNumberofProgress.text = "No Schedule Created"
        }
      
        
        
        
        // Do any additional setup after loading the view.
        RunningDataManager.createScheduleTable()

    }
    
    @IBAction func btnCreate(_ sender: Any) {
        btnCreateSchedules.isHidden = true
        btnStart.isHidden = false
    }
    
    func distanceAlert(){
        
        var Prevspeed : Double = 0
        var speeddiff : Double = 0
        var thissessionspeed : Double = time
        
      
        var LastSessionSpeed = RunningDataManager.loadPreviousSession(lastSessionID)
        
        
        
        if (travelledDistance/1000 >= lapdistance * 5 )
        {
            
            Prevspeed = LastSessionSpeed.lap5time!
            print("This is Prev time \(Prevspeed)")
            speeddiff = thissessionspeed - Prevspeed
            print("This is this time \(thissessionspeed)")
            
            var stringspeeddiff = String(speeddiff)
            print("This is speed diffrence \(stringspeeddiff)")
            if speeddiff < 0{
                var postive : String = String(speeddiff * -1)
                DistanceNotification = AVSpeechUtterance(string: "You are \(postive) seconds slower then faster round")
            }
            else {
                
                DistanceNotification = AVSpeechUtterance(string: "You are \(stringspeeddiff) seconds slower then last round")
            }
            if(callfirst == 1)
            {
                synth.speak(DistanceNotification)
                callfirst = 0
            }
        
        }
        else if (travelledDistance/1000 >= lapdistance * 4 )
        {
            Prevspeed = LastSessionSpeed.lap4time!
             print("This is Prev time \(Prevspeed)")
            speeddiff = thissessionspeed - Prevspeed
              print("This is this time \(thissessionspeed)")
            var stringspeeddiff = String(speeddiff)
               print("This is speed diffrence \(stringspeeddiff)")
            if speeddiff < 0{
                var postive : String = String(speeddiff * -1)
                DistanceNotification = AVSpeechUtterance(string: "You are \(postive) seconds faster then last round")
            }
            else {
               DistanceNotification = AVSpeechUtterance(string: "You are \(stringspeeddiff) slower faster then last round")
            }
            
            if(callsecond == 1)
            {
                synth.speak(DistanceNotification)
                callsecond = 0
            }
            
            
   
        }
        else if (travelledDistance/1000 >= lapdistance * 3 )
        {
            Prevspeed = LastSessionSpeed.lap3time!
             print("This is Prev time \(Prevspeed)")
            speeddiff = thissessionspeed - Prevspeed
             print("This is this time \(thissessionspeed)")
            var stringspeeddiff = String(speeddiff)
            print("This is speed diffrence \(stringspeeddiff)")
            if speeddiff < 0{
                var postive : String = String(speeddiff * -1)
                DistanceNotification = AVSpeechUtterance(string: "You are \(postive) seconds faster then last round")
            }
            else {
               DistanceNotification = AVSpeechUtterance(string: "You are \(stringspeeddiff) seconds slower then last round")
            }
            if(callthird == 1)
            {
                synth.speak(DistanceNotification)
                callthird = 0
            }
            
        }
        else if (travelledDistance/1000 >= lapdistance * 2 )
        {
            Prevspeed = LastSessionSpeed.lap2time!
            print("This is Prev time \(Prevspeed)")
            speeddiff = thissessionspeed - Prevspeed
             print("This is this time \(thissessionspeed)")
            var stringspeeddiff = String(speeddiff)
               print("This is speed diffrence \(stringspeeddiff)")
            if speeddiff < 0{
                var postive : String = String(speeddiff * -1)
                DistanceNotification = AVSpeechUtterance(string: "You are \(postive) seconds faster then last round")
            }
            else {
              DistanceNotification = AVSpeechUtterance(string: "You are \(stringspeeddiff) seconds slower then last round")
            }
            if(callfourth == 1)
            {
                synth.speak(DistanceNotification)
                callfourth = 0
            }
        }
        else if (travelledDistance/1000 >= lapdistance)
        {
            Prevspeed = LastSessionSpeed.lap1time!
            print("This is Prev time \(Prevspeed)")
            speeddiff = thissessionspeed - Prevspeed
             print("This is this time \(thissessionspeed)")
            var stringspeeddiff = String(speeddiff)
               print("This is speed diffrence \(stringspeeddiff)")
            if speeddiff < 0{
                var postive : String = String(speeddiff * -1)
                DistanceNotification = AVSpeechUtterance(string: "You are \(postive) seconds slower then last round")
            }
            else {
               DistanceNotification = AVSpeechUtterance(string: "You are \(stringspeeddiff) seconds faster then last round")
            }
            if(callfifth == 1)
            {
                synth.speak(DistanceNotification)
                callfifth = 0
            }        
        }
    }


    func ZombieAlert (){
        zombiedistance = zombiespeed * zombietime
    
        print(zombiedistance)
        
        if(time == 0){
            
            ZombieDangerous = AVSpeechUtterance(string: "Zombie is Behind you")
            ZombieDangerous.rate = 0.5
            ZombieSafe = AVSpeechUtterance(string: "You are in a safe distance currently")
            ZombieSafe.rate = 0.5
            ZombieNotTooDangerous = AVSpeechUtterance(string: "Zombie is still closing up")
            ZombieSafe.rate = 0.5
          
        }
        if (time >= 3){
            zombietime += 1
            audioPlayer.play()
        }
        
        if (zombiedistance > travelledDistance - 10)
        {
            ZombieDangerousshortimer += 1
            audioPlayer.volume = 1.0
            
            
            if(self.ZombieDangerousshortimer == 10 && zombiedistance > travelledDistance - 10)
            {
                synth.speak(ZombieDangerous)
                ZombieDangerousshortimer = 0
            }
        
        }
        else if ( travelledDistance - 10 <= zombiedistance && zombiedistance >= travelledDistance - 30)
        {
            audioPlayer.volume = 0.7
            ZombieNotTooDangerousTime += 1
            if(self.ZombieNotTooDangerousTime == 10 && travelledDistance - 10 <= zombiedistance && zombiedistance >= travelledDistance - 30)
            {
                synth.speak(ZombieNotTooDangerous)
                ZombieNotTooDangerousTime = 0
            }
            
        }
        else if (travelledDistance - 30 <= zombiedistance && zombiedistance >= travelledDistance - 50)
        {
            audioPlayer.volume = 0.5
            ZombieSafeTimer += 1
            if(self.ZombieSafeTimer == 10 && travelledDistance - 30 <= zombiedistance && zombiedistance >= travelledDistance - 50)
            {
                synth.speak(ZombieNotTooDangerous)
                ZombieSafeTimer = 0
            }
        }
        
        
    }

    
    
    @IBAction func SwitchZombie(_ sender: UISwitch) {
        
        if (sender.isOn == true)
        {
            lblZombie.text = "Zombie Mode!"
        }
        else
        {
            lblZombie.text = "Default Mode"
        }
    }
    
    
    
    
    func FinishAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Start Timer

    @IBAction func start(_ sender: UIButton) {
        BackProgress.isHidden = true
        lblprogress.isHidden = true
        lblNumberofProgress.isHidden = true
        lblProgress.isHidden = true
        mapView.isHidden = false
        measure2view.isHidden = false
        Measure1view.isHidden = false
        WeatherViewBeforeStart.isHidden = true
        setupCoreLocation()
        //Creating Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RunningTimerViewController.action), userInfo: nil, repeats: true)
        let monthformater = DateFormatter()
        monthformater.dateFormat = "LLLL"
        var letnameofmonth = monthformater.string(from: Date())
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
    
        
        let currentSession = Session(RunningDataManager.selectlastScheduleTableId(username),0.0,targetDistance,lblTime.text!,myStringafd,0,letnameofmonth,username)
      
            
        RunningDataManager.insertOrReplaceSession(session: currentSession)
          lastSessionID = RunningDataManager.selectlastSessionTableId() - 1
        
        let estimateddistance = String(targetDistance/5)
        lapdistance = Double(estimateddistance)!
        print(lapdistance)
        var SessionLapDistance = Session(firstdistance :estimateddistance,seconddistance :estimateddistance,thirddistance :estimateddistance,fourthdistance :estimateddistance,fifthdistance :estimateddistance,RunningDataManager.selectlastSessionTableId())
        RunningDataManager.UpdateSessionDistance(session: SessionLapDistance)
        
        //Alert Zombie Mode started
        if(ZombieModeSwitch.isOn == true)
        {
        ZombieWarning = AVSpeechUtterance(string: "Zombie is coming! Run!")
        ZombieWarning.rate = 0.5
        synth.speak(ZombieWarning)
        }
  
        
        //Hide redundant data
        if(timer!.isValid == true)
        {
            btnStart.isHidden = true
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
        case .authorizedWhenInUse:
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
        
        if startDate == nil{
            startDate = Date()
        } else {
            print("elapsedTime :", String(format: "%.0fs",Date().timeIntervalSince(startDate)))
        }
        if startlocation == nil{
            startlocation = locations.first
            longitude = String(startlocation.coordinate.longitude)
            latitude = String(startlocation.coordinate.latitude)
            self.weatherService.delegate = self
            self.weatherService.getWeatherForCity(lat: latitude, lon : longitude)
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
        
        if(speed.isNaN || speed.isInfinite){
            lblspeed.text = "0"
        }
        else{
        //Convert time to meter/second
        self.lblspeed.text = String(format :"%.2f",speed)
        }
        
        
        
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
        
        var estimateddistance : Double = targetDistance/5
        var finishingtime: String = lblTime.text!
      
        if (travelledDistance/1000 >= (estimateddistance * 5)){
            lap5Speed = lblspeed.text!
            lap5time = time
        }
        else if (travelledDistance/1000 >= (estimateddistance * 4)){
            lap4Speed = lblspeed.text!
            lap4time = time
        }
        else if (travelledDistance/1000 >= (estimateddistance * 3)){
            lap3Speed = lblspeed.text!
            lap3time = time
        }
        else if (travelledDistance/1000 >= (estimateddistance * 2)){
            lap2Speed = lblspeed.text!
            lap2time = time
        }
        else if(travelledDistance/1000 >= estimateddistance){
            lap1Speed = lblspeed.text!
            lap1time = time
        }
        if ZombieModeSwitch.isOn == true{
            ZombieAlert()
        }
        if ZombieModeSwitch.isOn == false{
            distanceAlert()
        }
        btnComplete.isHidden == false
        
        if(targetDistance != 0)
        {
        if(travelledDistance/1000 >= targetDistance)
        {
            var currentFinishTime = Session(time: finishingtime,RunningDataManager.selectlastSessionTableId())
            RunningDataManager.UpdateTotalTime(session: currentFinishTime)
            FinishAlert(title:"Finish",message:"You have completed the jog/run")
            btnComplete.isHidden = false
            buttonPause.isHidden = true
            btncontinue.isHidden = true
            disableLocationServices()
            var currentprogress: String = String(thisprogress + 1)
            var currentcomplete: Schedule = Schedule(currentprogress,scheduleid)
            RunningDataManager.UpdateProgress(Schedule: currentcomplete)
           // FinishedCurrentSchedule()
            
            var thisSessionSpeed = Session(firstspeed : lap1Speed,secondspeed : lap2Speed,thirdspeed : lap3Speed,fourthspeed : lap4Speed,fivespeed : lap5Speed,RunningDataManager.selectlastSessionTableId())
            RunningDataManager.UpdateSessionSpeed(session: thisSessionSpeed)
            
            var thistotalcaloriesburnt = Session(sessionid: RunningDataManager.selectlastSessionTableId(), totalcalories:calorie)
            RunningDataManager.UpdateTotalCalories(session: thistotalcaloriesburnt)
            
            var thistotaldistance = Session(sessionid: RunningDataManager.selectlastSessionTableId(), currentdistance: travelledDistance/1000)
            RunningDataManager.UpdateCurrentDistance(session: thistotaldistance)
            
            var thiscompletesession = Session(sessionid : RunningDataManager.selectlastSessionTableId(), sessioncomplete : 1)
            RunningDataManager.UpdateCurrentComplete(session: thiscompletesession)
            
            var thisSessionLapTime = Session(firsttime :lap1time,secondtime :lap2time,thirdtime :lap3time,fourthtime :lap4time,fivetime :lap5time, RunningDataManager.selectlastSessionTableId())
            RunningDataManager.UpdateSessiontime(session: thisSessionLapTime)
            
        /*    var thisSessionTotalSpeed = Session(sessionid : RunningDataManager.selectlastSessionTableId(), totalspeed :String(lblspeed.text!))
            print(thisSessionSpeed)
            RunningDataManager.UpdateTotalSpeed(session: thisSessionSpeed)
 */
            
            var thiscurrentdistance = Session(sessionid: RunningDataManager.selectlastSessionTableId(),currentdistance: travelledDistance/1000)
            RunningDataManager.UpdateCurrentDistance(session: thiscurrentdistance)
            
            var thistotalspeed = Session(sessionid: RunningDataManager.selectlastSessionTableId(),totalspeed : (travelledDistance/time))
            RunningDataManager.UpdateTotalSpeed(session: thistotalspeed)
            
      
            
            var RunLongitude : [String] = []
            var RunLatitude : [String] = []
           
            
            for location in mylocations{
                
                RunLongitude.append(String(location.coordinate.longitude))
                RunLatitude.append(String(location.coordinate.latitude))
                
            }
            
                var thiscurrentsessionlongitude = convertArrayToString(RunLongitude)
                var thiscurrentsessionlatitude = convertArrayToString(RunLatitude)
            
            var thisrunninglocation = Session(longitude: thiscurrentsessionlongitude, latitude: thiscurrentsessionlatitude,RunningDataManager.selectlastSessionTableId())
            
            RunningDataManager.UpdateLocation(session: thisrunninglocation)
            
            
            audioPlayer.stop()
            timer!.invalidate()
        }
        }
            
        
        }
    func convertArrayToString(_ arr:[String]) -> String{
       
        let stringRepresentation =  arr.joined(separator:  ",")
        
        return stringRepresentation
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
    
    func PrevtimeString(timing: Double) ->String{

        let minute = Int(timing) / 60 % 60
        let second = Int(timing) % 60
        
        return String(format: "%02i:%02i",minute,second)
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
