//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MaterialComponents

class DietaryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var reccCal: UILabel!
    @IBOutlet weak var intakeCal: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var progressBar: KDCircularProgress!
    
    @IBOutlet weak var summary: MDCFlatButton!
    
    var pickerData: [String] = ["None","Lose Weight", "Gain Weight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI stuff
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        lifestyleTheme.styleBtn(btn: summary, title: "In-depth Summary", pColor: colors.primaryDarkColor)

        //pickerView
        self.picker.dataSource = self;
        self.picker.delegate = self;
        self.picker.reloadAllComponents()
        let goal = LoadingData.shared.goals
        self.picker.selectRow(goal, inComponent: 0, animated: true)
        
        // today calorie intake
        var rcalories = LoadingData.shared.rcalories
        let extra = (rcalories/100)*10
        if goal == 1 {
            rcalories = rcalories - extra
        }
        else if goal == 2{
            rcalories = rcalories + extra
        }
        
        let intake: Double = 500.0
        let calories = Double(LoadingData.shared.rcalories)
        let percent = (intake/calories)*100
        let angle = (360/100)*percent
        self.progressBar.animate(fromAngle: self.progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
        self.intakeCal.text = Int(intake).description
        self.reccCal.text = rcalories.description

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NutrInfo.updateGoals(goal: row)
        
        var rcalories = LoadingData.shared.rcalories
        let extra = (rcalories/100)*10
        if row == 1 {
            rcalories = rcalories - extra
            self.reccCal.text = rcalories.description
        }
        else if row == 2{
            rcalories = rcalories + extra
            self.reccCal.text = rcalories.description
        }
        else{
            self.reccCal.text = rcalories.description
        }
    }
}
