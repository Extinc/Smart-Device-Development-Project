//
//  RunningPaceViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 29/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import JBChartView

class RunningPaceViewController: UIViewController,JBLineChartViewDelegate,JBLineChartViewDataSource {
    var speed1 : Double = 0
    var speed2 : Double = 0
    var speed3 : Double = 0
    var speed4 : Double = 0
    var speed5 : Double = 0
    var intspeedlist : [Double] = []
    var selectedid = Int()
    var RunningChartLegend = ["Lap 1","Lap 2","Lap 3","Lap 3","Lap 4","Lap 5"]
    var RunningChartSpeed : Session = Session(firstspeed: "", secondspeed: "", thirdspeed: "", fourthspeed: "", fifthspeed: "")
    var RunningChartDistance : Double = 0
    var RunningTime : [String] = []
    
    @IBOutlet weak var handgestureinstruction: UIView!
    
    @IBOutlet weak var lblinstruction: UILabel!
    @IBOutlet weak var tapView: UIImageView!
    @IBOutlet weak var linechart: JBLineChartView!
    @IBOutlet weak var informationLabel: UILabel!
    var chartLegend = ["11-14","11-15","11-16","11-17","11-18","11-19","11-20"]
    var chartData = [70,80,76,80,90,69,74]
    
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        RunningChartDistance = Double(RunningDataManager.loadSessionLapDistancebyID(selectedid))!
        RunningChartSpeed = RunningDataManager.loadSessionSpeed(selectedid)
        speed1 = Double(RunningChartSpeed.lap1speed!)!
        speed2 = Double(RunningChartSpeed.lap2speed!)!
        speed3 = Double(RunningChartSpeed.lap3speed!)!
        speed4 = Double(RunningChartSpeed.lap4speed!)!
        speed5 = Double(RunningChartSpeed.lap5speed!)!
 
        intspeedlist.append(speed1)
        intspeedlist.append(speed2)
        intspeedlist.append(speed3)
        intspeedlist.append(speed4)
        intspeedlist.append(speed5)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.someAction(_sender:)))
        
        handgestureinstruction.addGestureRecognizer(gesture)
        
        
        view.backgroundColor = UIColor.white
        linechart.backgroundColor = UIColor.white
        linechart.delegate = self
        linechart.dataSource = self
        linechart.minimumValue = 0
        
        linechart.maximumValue = 15
        //Add label
        var footerView = UIView(frame: CGRect(x: 0, y: 0, width: linechart.frame.width, height: 30))
        
        var footer1 = UILabel(frame: CGRect(x: 0, y: 0, width: linechart.frame.width/2 - 8, height: 16))
        footer1.textColor = UIColor.darkGray
        footer1.text = "\(RunningChartLegend[0])"
     
        var footer2 = UILabel(frame: CGRect(x: linechart.frame.width/2 - 8, y: 0 ,width: linechart.frame.width/2 - 8, height: 16))
        footer2.textColor = UIColor.darkGray
        footer2.text = "\(RunningChartLegend[RunningChartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.right
       
   
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
   
        //Add title for the graph
        var header = UILabel(frame: CGRect(x: 0, y: 0, width: linechart.frame.width, height: 50))
        header.textColor = UIColor.darkGray
        header.font = UIFont.systemFont(ofSize: 18)
        header.text = "Average Running Pace"
        header.textAlignment = NSTextAlignment.center
        
        linechart.footerView = footerView
        linechart.headerView = header
        
        
        // to - do add footer, header
        
        linechart.reloadData()
        
        linechart.setState(.collapsed, animated: false)
        
        showChart()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        linechart.reloadData()
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    //When the user click , instruction disappear
    @objc func someAction(_sender:UITapGestureRecognizer){
        handgestureinstruction.isHidden = true
        tapView.isHidden = true
        lblinstruction.isHidden = true
    }
    
    func viewDidDisappear(animated: Bool){
        super.viewDidDisappear(animated)
        hideChart()
    }
    func hideChart(){
        linechart.setState(.collapsed, animated: true)
    }
    func showChart(){
        linechart.setState(.expanded, animated: true)
    }
    
    //MARK: JBlinechartView
    func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
   
    func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if(lineIndex == 0){
            return CGFloat(intspeedlist[Int(horizontalIndex)])
        }
        return 0
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0){
            return UIColor.darkGray
        }
        return UIColor.darkGray
        
    }
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex: UInt, atLineIndex: UInt) -> UIColor
    {
        return UIColor.darkGray
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    // When the user hover in the graph the text display the information
    func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAt lineIndex: UInt, horizontalIndex: UInt) {
        if(lineIndex == 0)
        {
            
            var distance : Double = 0 * intspeedlist[Int(horizontalIndex)]
            let speed : Double = intspeedlist[Int(horizontalIndex)]
            var distancecheck = Int(horizontalIndex)
            
            if distancecheck == 0 {
                 distance = 1 * RunningChartDistance
            }
            if distancecheck == 1 {
                 distance = 2 * RunningChartDistance
            }
            if distancecheck == 2 {
                 distance = 3 * RunningChartDistance
            }
            if distancecheck == 3 {
                 distance  = 4 * RunningChartDistance
            }
            if distancecheck == 4 {
                 distance  = 5 * RunningChartDistance
            }
            
            informationLabel.text =  "Your running speed is \(speed)m/s at \(distance)km"
            
    
        }
    }
    
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        informationLabel.text = ""
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0){
            return UInt(intspeedlist.count)
        }
        
        return 0
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
