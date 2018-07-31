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
class WorkoutHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var dateTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    var numbers : [Double] = [13,12,10,9,20,21]
    var workoutHist: [WorkoutHist] = []
    var muscles: [String]! = ["Chest", "Forearms", "Lats", "Middle Back", "Lower Back", "Neck", "Quadriceps", "Hamstrings", "Calves", "Triceps", "Traps", "Shoulders", "Abdominals", "Glutes", "Biceps", "Adductors", "Abductors"]
    var week: [String]! = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var filteredHist: [WorkoutHist] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showDatePicker()
        
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
            
            self.filteredHist = self.workoutHist.filter({ (hist) -> Bool in
                return Calendar.current.isDate(hist.timeStamp, inSameDayAs:Date())
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredHist[indexPath.row].name
        cell.detailTextLabel?.text = "Count: \(filteredHist[indexPath.row].count!)      Type: \(filteredHist[indexPath.row].type!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTF.text = formatter.string(from: datePicker.date)
        labelDate.text = getDayOfWeekString(date: datePicker.date)
        filteredHist = workoutHist.filter({ (hist) -> Bool in
            return Calendar.current.isDate(hist.timeStamp, inSameDayAs: datePicker.date)
        })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateGraph(_ dataPoints: [String]){
        
        
        var histGrped: [[WorkoutHist]] = []
        var lines: [LineChartDataSet] = []
        var lineChartEntries: [[ChartDataEntry]] = []
        var muscforLine: [String] = []
        for muscle in muscles {
            if workoutHist.contains(where: { $0.type == muscle }) {
                histGrped.append(workoutHist.filter({ (hist) -> Bool in
                    print("Muscles: \(muscle) , type: \(hist.type)")
                    return hist.type == muscle
                }))
            } else {
                // not
            }
            
        }
        print("newGrp: ", histGrped)
        let data = LineChartData() //This is the object that will be added to the chart
        for i in 0..<histGrped.count {
            var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
            var muscle: String!
            for j in 0..<histGrped[i].count{
                
                if checkisWithinDays(date: histGrped[i][j].timeStamp) == true {
                    
                    var weekindex: Int =  week.index(of: getDayOfWeekString(date: histGrped[i][j].timeStamp))!
                    print("T!: ", weekindex)
                    let value = ChartDataEntry(x: Double(weekindex), y: Double(histGrped[i][j].count)) // here we set the X and Y status in a data chart entry
                    lineChartEntry.append(value) // here we add it to the data set
                    muscle = histGrped[i][j].type
                }
            }
            print("LineEntry Count: ", lineChartEntry.count)
            lineChartEntries.append(lineChartEntry)
            print("Lines:", i)
            let line1 = LineChartDataSet(values: lineChartEntry, label: muscle) //Here we convert lineChartEntry to a LineChartDataSet
            line1.colors = [NSUIColor.blue] //Sets the colour to blue
            data.addDataSet(line1) //Adds the line to the dataSet
            
        }
        
        
        chart.data = data //finally - it adds the chart data to the chart and causes an update
        chart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        chart.xAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
    }
    
    func getDayOfWeekString(date: Date)->String! {

        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let components = calendar!.components([.weekday], from: date)
        
        let weekDay = components.weekday
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
    
    func checkisWithinDays(date: Date) -> Bool {
        // Replace the hour (time) of both dates with 00:00
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: date)
        let fromDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let tDate = Calendar.current.date(byAdding: .day, value: +7, to: Date())
        return date.isBetweeen(date: Date(), andDate: fromDate!) || date.isBetweeen(date: Date(), andDate: tDate!)
    }
}

extension Date {
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self as Date) == self.compare(date2)
    }
}
