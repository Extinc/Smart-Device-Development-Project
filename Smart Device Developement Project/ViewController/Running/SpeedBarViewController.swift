//
//  SpeedBarViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 9/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import JBChartView

class SpeedBarViewController: UIViewController,JBBarChartViewDelegate, JBBarChartViewDataSource {
    
    
   
    

    @IBOutlet weak var barChart: JBBarChartView!
    @IBOutlet weak var InformationLabel: UILabel!
    
    var chartLegend = ["11-14","11-15","11-16","11-17","11-18","11-19","11-20"]
    var chartData = [70,80,76,88,90,69,74]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGray
        
        //Set barchart
        barChart.backgroundColor =  UIColor.darkGray
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = 100
        
        barChart.reloadData()
        barChart.setState(.collapsed, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        barChart.reloadData()
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
     
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    func hideChart(){
        barChart.setState(.collapsed, animated: true)
    }
    func showChart(){
        barChart.setState(.expanded, animated: true)
    }
   
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
         return UInt(chartData.count)
    }
 /*   func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        return( index % 2 == 0) ? UIColor.lightGray : UIColor.white
    }
 */
    
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        return( index % 2 == 0) ? UIColor.lightGray : UIColor.white
    }
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt, touch touchPoint: CGPoint) {
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]
        InformationLabel.text = "Weather"
    }
    //MARK: JBBarChartView
   
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

}
