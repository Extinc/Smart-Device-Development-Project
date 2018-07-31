//
//  WorkoutHistoryViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 30/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import JBChartView
import Charts
class WorkoutHistoryViewController: UIViewController{


    @IBOutlet weak var chart: LineChartView!
    
    var numbers : [Double] = [13,12,10,9,20,21]
    var workoutHist: [WorkoutHist] = []
    var week: [String]! = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(ExerciseDataManager.getWorkoutHistory(onComplete: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ExerciseDataManager.getWorkoutHistory { (hist) in
            self.workoutHist = hist
            self.updateGraph(self.week)
        }
        

    }
    
    func updateGraph(_ dataPoints: [String]){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        print(workoutHist)
        for i in 0..<workoutHist.count {
        
            let value = ChartDataEntry(x: Double(i), y: Double(workoutHist[i].count)) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
     
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
    
        chart.data = data //finally - it adds the chart data to the chart and causes an update
        chart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        chart.xAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
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
