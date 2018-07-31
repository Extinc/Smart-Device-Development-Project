//
//  HistorySessionViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit
import Charts
import JBChartView

/*private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
 
}*/


class HistorySessionViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,ChartViewDelegate{
 
    let tableimages : [[UIImage]] = [[#imageLiteral(resourceName: "table1")],[#imageLiteral(resourceName: "table2")],[#imageLiteral(resourceName: "table3")],[#imageLiteral(resourceName: "table4")]]
    
     var data = [[String]]()
     let header: [String] = ["Time taken","Distance","Calories","Average Speed"]
    
    @IBOutlet weak var Linechart: LineChartView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.imageView?.image = tableimages[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
 
   
 
    
    @IBOutlet weak var historyMap: MKMapView!
    
    @IBOutlet weak var btnAverageSpeed: UIButton!
    
    
    @IBOutlet weak var lblavgspeed: UILabel!
    
    @IBOutlet weak var lblTotalTime: UILabel!
    
    @IBOutlet weak var lblTotalDistance: UILabel!
    
    @IBOutlet weak var lblTotalCaloriesBurnt: UILabel!
    
    @IBOutlet weak var historytable: UITableView!
    
    @IBOutlet weak var barChart: JBBarChartView!
    
   
    
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
        var startpin = MKPointAnnotation()
        startpin.title = "Starting Spot"
        startpin.subtitle = "Started from here"
        var endpin = MKPointAnnotation()
        endpin.title = "End Spot"
        endpin.subtitle = "Ended here"
        historytable.delegate = self
        historytable.dataSource = self
        let headerView = UIView()
        headerView.backgroundColor = UIColor.darktextcolor
        headerView.frame = CGRect(x:0, y:0, width: view.frame.width, height: 30)
    
        
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
                if i == 0 {
                    var startlocation:CLLocationCoordinate2D = mylocations[0].coordinate
                    startpin.coordinate = startlocation
                    historyMap.addAnnotation(startpin)
                }
                if i == longitude.count - 1 {
                     var endlocation:CLLocationCoordinate2D = mylocations[mylocations.count - 1].coordinate
                      endpin.coordinate = endlocation
                    historyMap.addAnnotation(endpin)
                }
                
        }
      
       
        for i in 0 ..< longitude.count - 1 {
   
         var sourceIndex = i
    
            destinationIndex = i + 1;
            let c1 = mylocations[sourceIndex].coordinate
            let c2 = mylocations[destinationIndex].coordinate
            var a = [c1,c2]
            print("\(a)")
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            historyMap.add(polyline)
            
        }
   
         var time = (selectedSession.totaltime!) + " hours"
        var distance = "\(String(format: "%.2f",selectedSession.totaldistance!)) Km"
        var calories = "\(String(format: "%.2f", selectedSession.totalcaloriesburnt!)) Cal"
        var speed = "\(String(format: "%.2f", selectedSession.totalspeed!)) m/s"
       
        var timearray : [String] = [time]
        var distancearray : [String] = [distance]
        var caloriesarray : [String] = [calories]
        var speedarray : [String] = [speed]
        
        data.append(timearray)
        data.append(distancearray)
        data.append(caloriesarray)
        data.append(speedarray)
        
        
        
        
        
  
        
        
        historyMap.delegate = self
        locationManager.delegate = self
        updateMapRegion(rangeSpan: 1000)
 
       
    }
    
    
 /*   func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        barChart.reloadData()
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    func viewDidDisappear(animated: Bool){
        super.viewDidDisappear(animated)
        hideChart()
    }
    func hideChart(){
        barChart.setState(.collapsed, animated: true)
    }
    func showChart(){
        barChart.setState(.expanded, animated: true)
    }
    
    //MARK: JBBarChartView
    
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        return (index % 2 == 0) ? UIColor.lightGray : UIColor.white
    }
    
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt) {
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]

    }*/
    
 
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var nextcontroller = segue.destination as! RunningPaceViewController
        nextcontroller.selectedid = Int(currentid)!
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
