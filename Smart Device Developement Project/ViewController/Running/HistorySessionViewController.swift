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

private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

class HistorySessionViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,ChartViewDelegate{
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
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
        Linechart.delegate = self as! ChartViewDelegate
        Linechart.setViewPortOffsets(left: 0, top: 20, right: 0, bottom: 0)
        Linechart.backgroundColor = UIColor(red: 104/225, green: 241/225, blue:175/255, alpha: 1)
        
        Linechart.dragEnabled = true
        Linechart.setScaleEnabled(true)
        Linechart.pinchZoomEnabled = false
        Linechart.maxHighlightDistance = 300
        
        Linechart.xAxis.enabled = false
        let yAxis = Linechart.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light",size:12)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .white
        
        Linechart.rightAxis.enabled = false
        Linechart.legend.enabled = false
        
        Linechart.animate(xAxisDuration: 2, yAxisDuration: 2)
        
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
        
        func setDataCount(_ count: Int, range: UInt32){
            let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
                let mult = range + 1
                let val = Double(arc4random_uniform(mult) + 20)
                return ChartDataEntry(x: Double(i), y:val)
            }
            
            let set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
            set1.mode = .cubicBezier
            set1.drawCirclesEnabled = false
            set1.lineWidth = 1.8
            set1.circleRadius = 4
            set1.setCircleColor(.white)
            set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set1.fillColor = .white
            set1.fillAlpha = 1
            set1.drawHorizontalHighlightIndicatorEnabled = false
            set1.fillFormatter = CubicLineSampleFillFormatter()
            
            let data = LineChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
            data.setDrawValues(false)
            
          Linechart.data = data
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
   
         var time = (selectedSession.totaltime)
        var distance = "\(String(format: "%.2f",selectedSession.totaldistance!)) Km"
        var calories = "\(String(format: "%.2f", selectedSession.totalcaloriesburnt!)) Cal"
        var speed = "\(String(format: "%.2f", selectedSession.totalspeed!)) m/s"
       
        var timearray : [String] = [time!]
        var distancearray : [String] = [distance]
        var caloriesarray : [String] = [calories]
        var speedarray : [String] = [speed]
        
        data.append(timearray)
        data.append(distancearray)
        data.append(caloriesarray)
        data.append(speedarray)
        
        
        
        
        
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
