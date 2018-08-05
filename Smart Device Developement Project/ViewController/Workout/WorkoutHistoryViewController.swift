//
//  WorkoutHistoryViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 30/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//


// TODO: Remove this https://github.com/i-schuetz/SwiftCharts`
import UIKit
import SwiftCharts
import MaterialComponents
class WorkoutHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChartDelegate, IQDropDownTextFieldDelegate {
    
    fileprivate var chart: Chart? // arc
    fileprivate lazy private(set) var chartLongPressGestureRecognizer = UILongPressGestureRecognizer()
    private let axisLabelSettings: ChartLabelSettings = ChartLabelSettings()
    fileprivate var popups: [UIView] = []
    
    let datePicker = UIDatePicker()
    var selectedMusc: String!
    
    var numbers : [Double] = [13,12,10,9,20,21]
    var workoutHist: [WorkoutHist] = []
    var muscles: [String]! = ["Chest", "Forearms", "Lats", "Middle Back", "Lower Back", "Neck", "Quadriceps", "Hamstrings", "Calves", "Triceps", "Traps", "Shoulders", "Abdominals", "Glutes", "Biceps", "Adductors", "Abductors"]
    var filteredHist: [WorkoutHist] = []
    
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var chartHolder: UIStackView!
    @IBOutlet weak var chView: UIView!
    @IBOutlet weak var chartDisplay: UIStackView!
    @IBOutlet weak var muscGrpPicker: IQDropDownTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        showDatePicker()
        
        print(ExerciseDataManager.getWorkoutHistory(onComplete: nil))
        muscGrpPicker.delegate = self
        
        muscGrpPicker.dropDownMode = .textPicker
        muscGrpPicker.isOptionalDropDown = false
        muscGrpPicker.itemList = ["Chest", "Forearms", "Lats", "Middle Back", "Lower Back", "Neck", "Quadriceps", "Hamstrings", "Calves", "Triceps", "Traps", "Shoulders", "Abdominals", "Glutes", "Biceps", "Adductors", "Abductors"]
        labelDate.text = "Today"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedMusc = "Abductors"
        
        muscGrpPicker.setSelectedItem("Abductors", animated: false)
        
        ExerciseDataManager.getWorkoutHistory { (hist) in
            self.workoutHist = hist
            
            self.filteredHist = self.workoutHist.filter({ (hist) -> Bool in
                return hist.type == self.selectedMusc
            })
            
            if self.filteredHist.count == 0 {
                self.chartDisplay.addSubview(self.noDataDisplay(frame: self.chartDisplay.bounds))
            } else {
                self.chart = self.swiftChart()
                self.chartDisplay.addSubview((self.chart?.view)!)
            }
            
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End")
        selectedMusc = muscGrpPicker.selectedItem!
        self.chart?.clearView()
        self.chartDisplay.subviews.forEach({ $0.removeFromSuperview() })
        
        self.filteredHist = self.workoutHist.filter({ (hist) -> Bool in
            return hist.type == self.selectedMusc
        })
        if self.filteredHist.count == 0 {
            self.chartDisplay.addSubview(self.noDataDisplay(frame: self.chartDisplay.bounds))
        } else {
            self.chart = self.swiftChart()
            self.chartDisplay.addSubview((self.chart?.view)!)
        }
    }
    
    func noDataDisplay(frame: CGRect)->UIView{
        let views: UIView = UIView(frame: frame)
        let label = UILabel()
        
        label.text = "No Data"
         views.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: views.centerXAnchor).isActive = true
        
        label.centerYAnchor.constraint(equalTo: views.centerYAnchor).isActive = true
        label.textAlignment = .center
       
        return views
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
        if Date() != datePicker.date{
            labelDate.text = getDayOfWeekString(date: datePicker.date)
        }else {
            labelDate.text = "Today"
        }
        filteredHist = workoutHist.filter({ (hist) -> Bool in
            return Calendar.current.isDate(hist.timeStamp, inSameDayAs: datePicker.date)
        })

        self.view.endEditing(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    
    func swiftChart() -> Chart{
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMM"
        
        self.filteredHist = self.workoutHist.filter({ (hist) -> Bool in
            return hist.type == selectedMusc
        })
        
        var dateList: [Date] = []
        var countArr: [Int] = []
        
        let labelSettings = ChartLabelSettings(font: ChartDefaults.labelFont)
        var chartSettings = ChartDefaults.chartSettingsWithPanZoom
        chartSettings.trailing = 20
        chartSettings.top = 10
        chartSettings.labelsToAxisSpacingX = 20
        chartSettings.labelsToAxisSpacingY = 20
        // Set a fixed (horizontal) scrollable area 2x than the original width, with zooming disabled.
        chartSettings.zoomPan.maxZoomX = 2
        chartSettings.zoomPan.minZoomX = 2
        chartSettings.zoomPan.minZoomY = 1
        chartSettings.zoomPan.maxZoomY = 1
        
        //
        // For X Axis Labels
        //
        
        var xValues: [ChartAxisValue] = []
        var chartPoints: [ChartPoint] = []
        if self.filteredHist.count > 0 {
            for date in weeksInMonths() {
                dateList.append(date)
                
                xValues.append(createDateAxisValue(dateFormatter.string(from: date), readFormatter: dateFormatter, displayFormatter: displayFormatter))
                
            }
            
            for i in 0..<filteredHist.count{
                print("Test: ", filteredHist[i].timeStamp.isBetweeen(date: dateList[0], andDate: dateList[dateList.count-1]))
                if filteredHist[i].timeStamp.isBetweeen(date: dateList[0], andDate: dateList[dateList.count-1]){
                    countArr.append(filteredHist[i].count)
                    var chartpt = createChartPoint(dateStr: dateFormatter.string(from: filteredHist[i].timeStamp), percent: Double(filteredHist[i].count), readFormatter: dateFormatter, displayFormatter: displayFormatter)
                    chartPoints.append(chartpt)
                }
            }
        } else {
            
        }
        
        // For the graph lines
        
        

        
        //
        //
        var maxYVal:Int!

        if countArr.count >= 1 {
            maxYVal = countArr.max()! + 2
        } else {
            maxYVal = 0 + 2
        }
        
        
        var yValues:[ChartAxisValue] = []
        if let yValue:[ChartAxisValue]! = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 0, maxSegmentCount: Double(maxYVal), multiple: 1, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true) {
            yValues = yValue
        } else {
            yValues = stride(from: 0, through: 100, by: 10).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
        }
        //let yValues = stride(from: 0, through: 100, by: 10).map {ChartAxisValuePercent($0, labelSettings: labelSettings)

        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        let chartFrame = ChartDefaults.chartFrame(chartDisplay.bounds)
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: Colors.PrimaryColor(), lineWidth: 2, animDuration: 2	, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            for p in self.popups {p.removeFromSuperview()}
            
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            var selectedView: ChartPointTextCircleView?
            let v = ChartPointTextCircleView(chartPoint: chartPoint, center: screenLoc, diameter: Env.iPad ? 50 : 30, cornerRadius: Env.iPad ? 24: 15, borderWidth: Env.iPad ? 2 : 1, font: ChartDefaults.fontWithSize(Env.iPad ? 14 : 8))
            v.text = "\(chartPoint.y)"
            v.viewTapped = {view in
                let ibs = chart.view.subviews.compactMap { $0 as? InfoBubble }

                for ib in ibs {
                    //Do something with label
                    ib.backgroundColor = UIColor.white

                }
                self.removePopups()
                selectedView?.selected = false
                
                let w: CGFloat = Env.iPad ? 250 : 150
                let h: CGFloat = Env.iPad ? 100 : 80
                
                if let chartViewScreenLoc = layer.containerToGlobalScreenLoc(chartPoint) {
                    let x: CGFloat = {
                        let attempt = chartViewScreenLoc.x - (w/2)
                        let leftBound: CGFloat = chart.bounds.origin.x
                        let rightBound = chart.bounds.size.width - 5
                        if attempt < leftBound {
                            return view.frame.origin.x
                        } else if attempt + w > rightBound {
                            return rightBound - w
                        }
                        return attempt
                    }()
                    
                    let frame = CGRect(x: x, y: chartViewScreenLoc.y - (h + (Env.iPad ? 30 : 12)), width: w, height: h)
                    
                    let bubbleView = InfoBubble(point: chartViewScreenLoc, frame: frame, arrowWidth: Env.iPad ? 40 : 28, arrowHeight: Env.iPad ? 20 : 14, bgColor: UIColor.black, arrowX: chartViewScreenLoc.x - x, arrowY: -1) // TODO don't calculate this here
                    chart.view.addSubview(bubbleView)
                    
                    bubbleView.transform = CGAffineTransform(scaleX: 0, y: 0).concatenating(CGAffineTransform(translationX: 0, y: 100))
                    let infoView = UILabel(frame: CGRect(x: 0, y: 10, width: w, height: h - 30))
                    infoView.numberOfLines = 2
                    infoView.textColor = UIColor.white
                    infoView.backgroundColor = UIColor.black
                    infoView.text = "\(chartPoint.x) \n \(chartPoint.y)"
                    infoView.font = ChartDefaults.fontWithSize(Env.iPad ? 14 : 12)
                    infoView.textAlignment = NSTextAlignment.center
                    
                    bubbleView.addSubview(infoView)
                    self.popups.append(bubbleView)
                    
                    UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations: {
                        view.selected = true
                        selectedView = view
                        
                        bubbleView.transform = CGAffineTransform.identity
                    }, completion: {finished in})
                }
            }
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
                let w: CGFloat = v.frame.size.width
                let h: CGFloat = v.frame.size.height
                let frame = CGRect(x: screenLoc.x - (w/2), y: screenLoc.y - (h/2), width: w, height: h)
                v.frame = frame
            }, completion: nil)
            
            return v
            
        }
        let itemsDelay: Float = 0.08
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 2.7, delayBetweenItems: itemsDelay, mode: .translate)
        
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        //        let highlightLayer = ChartPointsTouchHighlightLayer(
        //            xAxisLayer: xAxisLayer,
        //            yAxisLayer: yAxisLayer,
        //            chartPoints: chartPoints,
        //            tintColor: UIColor.blue,
        //            labelCenterY: chartSettings.bottom,
        //            gestureRecognizer: chartLongPressGestureRecognizer,
        //            onCompleteHighlight: nil
        //        )
        
        
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsCircleLayer
            ]
        )


        return chart
        
    }
    
    fileprivate func removePopups() {
        for popup in popups {
            popup.removeFromSuperview()
        }
    }
    
    // MARK: - ChartDelegate
    
    func onZoom(scaleX: CGFloat, scaleY: CGFloat, deltaX: CGFloat, deltaY: CGFloat, centerX: CGFloat, centerY: CGFloat, isGesture: Bool) {
        removePopups()
    }
    
    func onPan(transX: CGFloat, transY: CGFloat, deltaX: CGFloat, deltaY: CGFloat, isGesture: Bool, isDeceleration: Bool) {
        removePopups()
    }
    
    func onTap(_ models: [TappedChartPointLayerModels<ChartPoint>]) {
    }
    
    
    func weeksInMonths() -> [Date]{
        print()
        print("weeksInMonths")
        
        var calendar = Calendar.current
        let date = Date()
        let weekOfYearRange = calendar.range(of: .weekOfYear, in: .month, for: date)
        //print(weekOfYearRange as Any)
        var dates: [Date] = []
        if let weekOfYearRange = weekOfYearRange {
            let year = calendar.component(.year, from: date)
            
            for weekOfYear in (weekOfYearRange.lowerBound..<weekOfYearRange.upperBound) {
                let components = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: year)
                guard let date = Calendar.current.date(from: components) else { continue }
                dates.append(date)
                print(date.description(with: Locale.current))
            }
        }
        
        return dates
    }
    
    func createChartPoint(dateStr: String, percent: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePercent(percent))
    }
    
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: ChartDefaults.labelFont, rotation: 0, rotationKeep: .top)
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    
    class ChartAxisValuePercent: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)"
        }
    }
    
    func getDayOfWeekString(date: Date)->String! {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let components = calendar!.components([.weekday], from: date)
        
        let weekDay = components.weekday
        switch weekDay {
        case 1?:
            return "Sun"
        case 2?:
            return "Mon"
        case 3?:
            return "Tue"
        case 4?:
            return "Wed"
        case 5?:
            return "Thu"
        case 6?:
            return "Fri"
        case 7?:
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
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
private extension ChartPointsTouchHighlightLayer {
    
    convenience init(
        xAxisLayer: ChartAxisLayer,
        yAxisLayer: ChartAxisLayer,
        chartPoints: [T],
        tintColor: UIColor,
        labelCenterY: CGFloat = 0,
        gestureRecognizer: UILongPressGestureRecognizer? = nil,
        onCompleteHighlight: (()->Void)? = nil
        ) {
        self.init(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, gestureRecognizer: gestureRecognizer, onCompleteHighlight: onCompleteHighlight,
                  modelFilter: { (screenLoc, chartPointModels) -> ChartPointLayerModel<T>? in
                    if let index = chartPointModels.map({ $0.screenLoc.x }).findClosestElementIndexToValue(screenLoc.x) {
                        return chartPointModels[index]
                    } else {
                        return nil
                    }
        },
                  viewGenerator: { (chartPointModel, layer, chart) -> U? in
                    let containerView = U(frame: chart.contentView.bounds)
                    
                    let xAxisOverlayView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 3 + containerView.frame.size.height), size: xAxisLayer.frame.size))
                    xAxisOverlayView.backgroundColor = UIColor.white
                    xAxisOverlayView.isOpaque = true
                    containerView.addSubview(xAxisOverlayView)
                    
                    let point = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 16)
                    point.fillColor = tintColor.withAlphaComponent(0.5)
                    containerView.addSubview(point)
                    
                    if let text = chartPointModel.chartPoint.y.labels.first?.text {
                        let label = UILabel()
                        if #available(iOS 9.0, *) {
                            label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .bold)
                        } else {
                            label.font = UIFont.systemFont(ofSize: 15)
                        }
                        
                        label.text = text
                        label.textColor = tintColor
                        label.textAlignment = .center
                        label.sizeToFit()
                        label.frame.size.height += 4
                        label.frame.size.width += label.frame.size.height / 2
                        label.center.y = containerView.frame.origin.y
                        label.center.x = chartPointModel.screenLoc.x
                        label.frame.origin.x = min(max(label.frame.origin.x, containerView.frame.origin.x), containerView.frame.maxX - label.frame.size.width)
                        label.frame.origin.makeIntegralInPlaceWithDisplayScale(chart.view.traitCollection.displayScale)
                        label.layer.borderColor = tintColor.cgColor
                        label.layer.borderWidth = 1 / chart.view.traitCollection.displayScale
                        label.layer.cornerRadius = label.frame.size.height / 2
                        label.backgroundColor = UIColor.white
                        
                        containerView.addSubview(label)
                    }
                    
                    if let text = chartPointModel.chartPoint.x.labels.first?.text {
                        let label = UILabel()
                        label.font = UIFont.systemFont(ofSize: 5)
                        label.text = text
                        label.textColor = UIColor.black
                        label.sizeToFit()
                        label.center = CGPoint(x: chartPointModel.screenLoc.x, y: xAxisOverlayView.center.y)
                        label.frame.origin.makeIntegralInPlaceWithDisplayScale(chart.view.traitCollection.displayScale)
                        
                        containerView.addSubview(label)
                    }
                    
                    return containerView
        }
        )
    }
}


private extension CGPoint {
    /**
     Rounds the coordinates to whole-pixel values
     - parameter scale: The display scale to use. Defaults to the main screen scale.
     */
    mutating func makeIntegralInPlaceWithDisplayScale(_ scale: CGFloat = 0) {
        var scale = scale
        
        // It's possible for scale values retrieved from traitCollection objects to be 0.
        if scale == 0 {
            scale = UIScreen.main.scale
        }
        x = round(x * scale) / scale
        y = round(y * scale) / scale
    }
}


private extension BidirectionalCollection where Index: Strideable, Iterator.Element: Strideable, Index.Stride == Int {
    /**
     Returns the index of the closest element to a specified value in a sorted collection
     - parameter value: The value to match
     - returns: The index of the closest element, or nil if the collection is empty
     */
    func findClosestElementIndexToValue(_ value: Iterator.Element) -> Index? {
        let upperBound = findInsertionIndexForValue(value)
        
        if upperBound == startIndex {
            if upperBound == endIndex {
                return nil
            }
            return upperBound
        }
        
        let lowerBound = upperBound.advanced(by: -1)
        
        if upperBound == endIndex {
            return lowerBound
        }
        
        if value.distance(to: self[upperBound]) < self[lowerBound].distance(to: value) {
            return upperBound
        }
        
        return lowerBound
    }
    
    /**
     Returns the insertion index of a new value in a sorted collection
     Based on some helpful responses found at [StackOverflow](http://stackoverflow.com/a/33674192)
     - parameter value: The value to insert
     
     - returns: The appropriate insertion index, between `startIndex` and `endIndex`
     */
    func findInsertionIndexForValue(_ value: Iterator.Element) -> Index {
        var low = startIndex
        var high = endIndex
        
        while low != high {
            let mid = low.advanced(by: low.distance(to: high) / 2)
            
            if self[mid] < value {
                low = mid.advanced(by: 1)
            } else {
                high = mid
            }
        }
        
        return low
    }
}
