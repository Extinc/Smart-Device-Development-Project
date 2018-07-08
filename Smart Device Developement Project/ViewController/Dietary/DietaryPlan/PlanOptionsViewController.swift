//
//  PlanOptionsViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import Firebase

class PlanOptionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var planTextField: UITextField!
    @IBOutlet weak var goalsTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var mealsperdayTextField: UITextField!
    @IBOutlet weak var mealtimingsTextField: UITextField!
    @IBOutlet weak var remindersTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    var picker3 = UIPickerView()
    var picker4 = UIPickerView()
    var picker5 = UIPickerView()
    var picker6 = UIPickerView()
    var datePicker: UIDatePicker?
    
    
    var dataPlan = ["Vegan", "Gluten Free", "Clean Eating", "Muscle Builder", "Keto", "Dash"]
    var dataGoals = ["Gain Weight", "Lose Weight", "Maintain Weight"]
    var dataDuration = ["1 Week", "2 Weeks", "1 Month", "3 Months", "6 Months"]
    var dataMealsPD = ["1", "2", "3", "4", "5", "6"]
    var dataMealsT = ["2 Hours","3 Hours", "4 Hours", "5 Hours", "6 Hours"]
    var dataReminders = ["Yes", "No"]
    
    var planpreferences = [UserPlanPreferences]()
    
    var preferences = ["test", "Vegan", "Lose Weight", "2 Weeks", "3", "2 Hours", "Yes"]
    var username = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.delegate = self
        picker2.delegate = self
        picker3.delegate = self
        picker4.delegate = self
        picker5.delegate = self
        picker6.delegate = self
        
        picker1.dataSource = self
        picker2.dataSource = self
        picker3.dataSource = self
        picker4.dataSource = self
        picker5.dataSource = self
        picker6.dataSource = self
        
        picker1.tag = 1
        picker2.tag = 2
        picker3.tag = 3
        picker4.tag = 4
        picker5.tag = 5
        picker6.tag = 6
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DietaryPlanViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        planTextField.inputView = picker1
        goalsTextField.inputView = picker2
        durationTextField.inputView = picker3
        mealsperdayTextField.inputView = picker4
        mealtimingsTextField.inputView = picker5
        remindersTextField.inputView = picker6
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
        dateFormatter.dateFormat = "dd/MM/yyyy"
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
        else if pickerView.tag == 2 {
            return dataGoals.count
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
        else if pickerView.tag == 6 {
            return dataReminders.count
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
        else if pickerView.tag == 2 {
            goalsTextField.text = dataGoals[row]
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
        else if pickerView.tag == 6 {
            remindersTextField.text = dataReminders[row]
            view.endEditing(true)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return dataPlan[row]
        }
        else if pickerView.tag == 2 {
            return dataGoals[row]
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
        else if pickerView.tag == 6 {
            return dataReminders[row]
        }
        else {
            return dataPlan[row]
        }
        
    }
    
    
    // MARK: - Navigation

    @IBAction func goBackToDPC(_ sender: Any) {
        if (planTextField.text == "" ||
            goalsTextField.text == "" ||
            durationTextField.text == "" ||
            mealsperdayTextField.text == "" ||
            mealtimingsTextField.text == "" ||
            remindersTextField.text == "" ||
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
        else {
            let dietplan = planTextField.text
            let goals = goalsTextField.text
            let duration = durationTextField.text
            let mpd = Int(mealsperdayTextField.text!)
            let mti = mealtimingsTextField.text
            let reminders = remindersTextField.text
            let startDate = startDateTextField.text
            
            let UP : UserPlanPreferences = UserPlanPreferences(username, dietplan!, goals!, duration!, mpd!, mti!, reminders!, startDate!)
            DietaryPlanDataManager.insertOrReplacePreferences(userPlanPreferences: UP)
            
            performSegue(withIdentifier: "unwindSegueToDPC", sender: self)
        }
       
    }
    
     // MARK: - Functions
    
}
