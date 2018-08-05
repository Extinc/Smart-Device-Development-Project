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
    
    //calories
    @IBOutlet weak var reccCal: UILabel!
    @IBOutlet weak var intakeCal: UILabel!
    @IBOutlet weak var progressBar: KDCircularProgress!

    //carbs
    @IBOutlet weak var intakeCarb: UILabel!
    @IBOutlet weak var reccCarb: UILabel!
    @IBOutlet weak var carbs: KDCircularProgress!
    
    //goals
    @IBOutlet weak var summary: MDCFlatButton!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = ["None","Lose Weight", "Gain Weight"]
    
    let date = Date()
    let formatter = DateFormatter()

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
        
        //today calorie intake
        let mealPlan:[MealPlan] = LoadingData.shared.mealPlan
        let meals:[Meal] = LoadingData.shared.mealList
        var rcalories = LoadingData.shared.rcalories
        var icalories:Int = 0

        //today carb intake
        var carbRecc = Double((rcalories/100)*60)
        var carbIntake:Double = 0.0

        //loop for today calories and carbohydrates
        for i in 0..<mealPlan.count{
            for _ in 0..<mealPlan[i].count!{
                icalories = Int(mealPlan[i].calories!) + icalories
                for x in 0..<meals.count{
                    if(mealPlan[i].mealID == meals[x].mealID){
                        carbIntake = Double(meals[x].carbohydrates!) + carbIntake
                    }
                }
            }
        }
        
        //loop for goals
        let extra = (rcalories/100)*10
        let extra2 = (carbRecc/100)*10
        if goal == 1 {
            rcalories = rcalories - extra
            carbRecc = carbRecc - extra2
        }
        else if goal == 2{
            rcalories = rcalories + extra
            carbRecc = carbRecc + extra2
        }
        
        
        //----------------calculate and display----------------------
        
        //calories
        let intake: Double = Double(icalories)
        let calories = Double(LoadingData.shared.rcalories)
        let percent = (intake/calories)*100
        let angle = (360/100)*percent
        
        if (intake > calories) {
            self.progressBar.progressColors = [UIColor.red]
        }
        self.progressBar.animate(fromAngle: self.progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
        self.intakeCal.text = Int(intake).description
        self.reccCal.text = rcalories.description
        
        //carbohydrates
        let C_percent = (carbIntake/carbRecc)*100
        let C_angle = (360/100)*C_percent
        
        if (carbIntake > carbRecc) {
            self.carbs.progressColors = [UIColor.red]
        }
        self.carbs.animate(fromAngle: self.carbs.angle, toAngle: C_angle, duration: 0.5, completion: nil)
        self.reccCarb.text = Int(carbRecc).description
        self.intakeCarb.text = Int(carbIntake).description

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
        var carbRecc = Double((rcalories/100)*60)
        
        let extra = (rcalories/100)*10
        let extra2 = (carbRecc/100)*10
        if row == 1 {
            rcalories = rcalories - extra
            carbRecc = carbRecc - extra2
            self.reccCal.text = rcalories.description
            self.reccCarb.text = Int(carbRecc).description
        }
        else if row == 2{
            rcalories = rcalories + extra
            carbRecc = carbRecc + extra2
            self.reccCal.text = rcalories.description
            self.reccCarb.text = Int(carbRecc).description
        }
        else{
            self.reccCal.text = rcalories.description
            self.reccCarb.text = Int(carbRecc).description
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        formatter.dateFormat = "dd-MM-yyyy"
        let today = formatter.string(from: date)
        let user = AuthenticateUser.getUID()
        let meals:[Meal] = LoadingData.shared.mealList
        
        DietaryPlanDataManagerFirebase.loadMealPlans(date: today, username: user){
            plan in
            var rcalories = LoadingData.shared.rcalories
            var icalories:Int = 0
            let goal = self.picker.selectedRow(inComponent: 0)

            //today carb intake
            var carbRecc = Double((rcalories/100)*60)
            var carbIntake:Double = 0.0
            
            //loop for today calories and carbohydrates
            for i in 0..<plan.count{
                for _ in 0..<plan[i].count!{
                    icalories = Int(plan[i].calories!) + icalories
                    for x in 0..<meals.count{
                        if(plan[i].mealID == meals[x].mealID){
                            carbIntake = Double(meals[x].carbohydrates!) + carbIntake
                        }
                    }
                }
            }
            
            //loop for goals
            let extra = (rcalories/100)*10
            let extra2 = (carbRecc/100)*10
            if goal == 1 {
                rcalories = rcalories - extra
                carbRecc = carbRecc - extra2
            }
            else if goal == 2{
                rcalories = rcalories + extra
                carbRecc = carbRecc + extra2
            }
            
            //calculate and display
            let intake: Double = Double(icalories)
            let calories = Double(LoadingData.shared.rcalories)
            let percent = (intake/calories)*100
            let angle = (360/100)*percent
            
            if (intake > calories) {
                self.progressBar.progressColors = [UIColor.red]
            }
            self.progressBar.animate(fromAngle: self.progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
            self.intakeCal.text = Int(intake).description
            self.reccCal.text = rcalories.description
            
            //carbohydrates
            let C_percent = (carbIntake/carbRecc)*100
            let C_angle = (360/100)*C_percent
            
            if (carbIntake > carbRecc) {
                self.carbs.progressColors = [UIColor.red]
            }
            self.carbs.animate(fromAngle: self.carbs.angle, toAngle: C_angle, duration: 0.5, completion: nil)
            self.reccCarb.text = Int(carbRecc).description
            self.intakeCarb.text = Int(carbIntake).description
        }
    }
}
