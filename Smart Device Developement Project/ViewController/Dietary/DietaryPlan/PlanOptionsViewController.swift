//
//  PlanOptionsViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class PlanOptionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var planTextField: UITextField!
    @IBOutlet weak var goalsTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var mealsperdayTextField: UITextField!
    @IBOutlet weak var mealtimingsTextField: UITextField!
    @IBOutlet weak var remindersTextField: UITextField!
    
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    var picker3 = UIPickerView()
    var picker4 = UIPickerView()
    var picker5 = UIPickerView()
    var picker6 = UIPickerView()
    
    
    var dataPlan = ["Vegan", "Gluten Free", "Clean Eating", "Muscle Builder", "Keto", "Dash"]
    var dataGoals = ["Gain Weight", "Lose Weight", "Maintain Weight"]
    var dataDuration = ["1 Week", "2 Weeks", "1 Month", "3 Months", "6 Months"]
    var dataMealsPD = ["1", "2", "3", "4", "5", "6"]
    var dataMealsT = ["2 Hours","3 Hours", "4 Hours", "5 Hours", "6 Hours"]
    var dataReminders = ["Yes", "No"]
    
    var planpreferences = [UserPlanPreferences]()
    
    var preferences = ["test", "Vegan", "Lose Weight", "2 Weeks", "3", "2 Hours", "Yes"]
    var username = "test"
    
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
        
        planTextField.inputView = picker1
        goalsTextField.inputView = picker2
        durationTextField.inputView = picker3
        mealsperdayTextField.inputView = picker4
        mealtimingsTextField.inputView = picker5
        remindersTextField.inputView = picker6
        
        //when user taps, usually keyboard comes up, disables the keyboard coming up
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PlanOptionsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        //loadPreferences()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Tap Gestures
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
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
        }
        else if pickerView.tag == 2 {
            goalsTextField.text = dataGoals[row]
        }
        else if pickerView.tag == 3 {
            durationTextField.text = dataDuration[row]
        }
        else if pickerView.tag == 4 {
            mealsperdayTextField.text = dataMealsPD[row]
        }
        else if pickerView.tag == 5 {
            mealtimingsTextField.text = dataMealsT[row]
        }
        else if pickerView.tag == 6 {
            remindersTextField.text = dataReminders[row]
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
    
    
   /* // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "optionsSegue") {
            let secondOptions = segue.destination as! PlanOptions2ViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow
            let chosenRow = tableData[(myIndexPath?.section)!]
            var optionsTableData = [String]()
            switch chosenRow{
                case "Type of Meal Plan":
                    optionsTableData = ["Vegan", "Gluten Free", "Clean Eating", "Muscle Builder", "Keto", "Dash"]
                case "Goals of Diet":
                    optionsTableData = ["Gain Weight", "Lose Weight", "Maintain Weight"]
                case "Duration of Diet":
                    optionsTableData = ["1 Week", "2 Weeks", "1 Month", "3 Months", "6 Months"]
                case "Meals per day":
                    optionsTableData = ["1", "2", "3", "4", "5", "6"]
                case "Meal Timings":
                    optionsTableData = ["2 Hours","3 Hours", "4 Hours", "5 Hours", "6 Hours"]
                case "Reminders before Meals":
                    optionsTableData = ["Yes", "No"]
                default:
                    optionsTableData = [ ""]
            }
            secondOptions.tableData = optionsTableData

        }
        
    }*/

    // MARK: - Functions
    
}
