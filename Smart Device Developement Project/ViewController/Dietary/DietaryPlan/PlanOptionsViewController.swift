//
//  PlanOptionsViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import UserNotifications


class PlanOptionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var planTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var mealsperdayTextField: UITextField!
    @IBOutlet weak var mealtimingsTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var remindersSwitch: UISwitch!
    
    @IBOutlet weak var intervalStackView: UIStackView!
    
    var picker1 = UIPickerView()
    var picker3 = UIPickerView()
    var picker4 = UIPickerView()
    var picker5 = UIPickerView()
    var picker6 = UIPickerView()
    var datePicker: UIDatePicker?
    
    
    var dataPlan = ["Normal", "Keto", "Dash"]
    var dataGoals = ["Gain Weight", "Lose Weight", "Maintain Weight"]
    var dataDuration = ["1 Week", "2 Weeks", "1 Month", "3 Months", "6 Months"]
    var dataMealsPD = ["1", "2", "3", "4", "5", "6"]
    var dataMealsT = ["2 Hours","3 Hours", "4 Hours", "5 Hours", "6 Hours"]
    
    var planpreferences = [UserPlanPreferences]()
    var username = ""
    var totalCalories: Int = 0
    var meal: [Meal] = []
    var planID: Int = 0
    var selectedDate: String = ""

    var reminders: String = "No"
    var isGrantedNotificationAccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intervalStackView.isHidden = true
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            self.isGrantedNotificationAccess = granted
            if !granted {
                //add alert to complain to user
            }
        }
        
        self.username = AuthenticateUser.getUID()
        self.meal = LoadingData.shared.mealList
        self.loadCalories()
        
        startDateTextField.text = selectedDate
        
        picker1.delegate = self
        picker3.delegate = self
        picker4.delegate = self
        picker5.delegate = self

        
        picker1.dataSource = self
        picker3.dataSource = self
        picker4.dataSource = self
        picker5.dataSource = self
   
        
        picker1.tag = 1
        picker3.tag = 3
        picker4.tag = 4
        picker5.tag = 5
 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dDate = dateFormatter.date(from: selectedDate)
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(PlanOptionsViewController.dateChanged(datePicker:)), for: .valueChanged)
        datePicker?.minimumDate = dDate
        
        planTextField.inputView = picker1
        durationTextField.inputView = picker3
        mealsperdayTextField.inputView = picker4
        mealtimingsTextField.inputView = picker5
        startDateTextField.inputView = datePicker
        
        
        
        //when user taps, usually keyboard comes up, disables the keyboard coming up
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PlanOptionsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Tap Gestures
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    // MARK: - UIPickerViews
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return dataPlan.count
        }
        else if pickerView.tag == 3 {
            return dataDuration.count
        }
        else if pickerView.tag == 4 {
            return dataMealsPD.count
        }
        else if pickerView.tag == 5 {
            return dataMealsT.count
        }
        else {
            return dataPlan.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            planTextField.text = dataPlan[row]
            view.endEditing(true)
        }
        else if pickerView.tag == 3 {
            durationTextField.text = dataDuration[row]
            view.endEditing(true)
        }
        else if pickerView.tag == 4 {
            mealsperdayTextField.text = dataMealsPD[row]
            view.endEditing(true)
        }
        else if pickerView.tag == 5 {
            mealtimingsTextField.text = dataMealsT[row]
            view.endEditing(true)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return dataPlan[row]
        }
        else if pickerView.tag == 3 {
            return dataDuration[row]
        }
        else if pickerView.tag == 4 {
            return dataMealsPD[row]
        }
        else if pickerView.tag == 5 {
            return dataMealsT[row]
        }
        else {
            return dataPlan[row]
        }
        
    }
    
    
    // MARK: - Navigation

    @IBAction func goBackToDPC(_ sender: Any) {
        
        if isGrantedNotificationAccess{
            //let content = RecommendMeal.makeNotiContent()
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 500, repeats: true)
        }
        
        if (planTextField.text == "" ||
            durationTextField.text == "" ||
            mealsperdayTextField.text == "" ||
            startDateTextField.text == "") {
            let alert = UIAlertController(title: "Please fill in all fields", message: "", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
            ))
            self.present(alert, animated:true, completion: nil)
            return
        }
        else{
            let duration = durationTextField.text
            let timingField = mealtimingsTextField.text
            var days: String = "0"
            var timing: String = "0"
            
            if(duration == "1 Week") {
                days = "7"
            }
            else if(duration == "2 Weeks"){
                days = "14"
            }
            else if(duration == "1 Month"){
                days = "30"
            }
            else if(duration == "3 Months"){
                days = "90"
            }
            else if(duration == "6 Months"){
                days = "180"
            }
            
            if(timingField == "2 Hours"){
                timing = "2"
            }
            else if (timingField == "3 Hours") {
                timing = "3"
            }
            else if (timingField == "4 Hours") {
                timing = "4"
            }
            else if (timingField == "5 Hours") {
                timing = "5"
            }
            else if (timingField == "6 Hours") {
                timing = "6"
            }
            else if (timingField == ""){
                timing = "0"
            }
            
            let dietplan = planTextField.text
            let mpd = Int(mealsperdayTextField.text!)
            let startDate = startDateTextField.text
            
            let UP : UserPlanPreferences = UserPlanPreferences(username, dietplan!, days, mpd!, timing, reminders, startDate!)
            DietaryPlanDataManager.insertOrReplacePreferences(userPlanPreferences: UP)
            
            RecommendMeal.createMealPlan(meals: meal, username: username, totalCalories: totalCalories, planid: planID)
            
            performSegue(withIdentifier: "unwindSegueToDPC", sender: self)
        }
       
    }
    
     // MARK: - Functions
    func loadCalories(){
        NutrInfo().calReccCalories() {
            recCaloriesFromFirebase in
            self.totalCalories = recCaloriesFromFirebase
        }
    }
    
    func loadPlanID(date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadPlanID(date: date, username: username){
            planIDFromFirebase in
            self.planID = planIDFromFirebase
        }
    }
    

    @IBAction func switchChanged(_ sender: Any) {
        if (remindersSwitch.isOn) {
            reminders = "Yes"
            intervalStackView.isHidden = false
        }
        else {
            reminders = "No"
            intervalStackView.isHidden = true
        }
    }
    
}
