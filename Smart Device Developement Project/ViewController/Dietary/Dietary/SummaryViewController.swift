//
//  SummaryViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 29/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    let date = Date()
    let formatter = DateFormatter()
    
    //UI
    @IBOutlet weak var titleView: UIView!
    
    //date picker
    @IBOutlet weak var datePick: UIDatePicker!
    
    //nutrition values
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var sodium: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        self.titleView.backgroundColor = Colors.PrimaryColor()
        
        
        //var
        formatter.dateFormat = "dd-MM-yyyy"
        let today = formatter.string(from: date)
        let user = AuthenticateUser.getUID()
        let meals:[Meal] = LoadingData.shared.mealList
        
        
        //method
        DietaryPlanDataManagerFirebase.loadMealPlans(date: today, username: user){
            plan in
            
            var calories:Int = 0
            var carb:Double = 0.0
            var fat:Double = 0.0
            var protein:Double = 0.0
            var sodium:Double = 0.0
            
            //loop for calories and carbohydrates
            for i in 0..<plan.count{
                for _ in 0..<plan[i].count!{
                    calories = Int(plan[i].calories!) + calories
                    for x in 0..<meals.count{
                        if(plan[i].mealID == meals[x].mealID){
                            carb = Double(meals[x].carbohydrates!) + carb
                            fat = Double(meals[x].fat!) + fat
                            protein = Double(meals[x].protein!) + protein
                            sodium = Double(meals[x].sodium!) + sodium
                        }
                    }
                }
            }
            //loop end
            
            self.calories.text = calories.description + " Kcal"
            self.carbs.text = String(format: "%.2f", carb) + " g"
            self.fat.text = String(format: "%.2f", fat) + " g"
            self.protein.text = String(format: "%.2f", protein) + " g"
            self.sodium.text = String(format: "%.2f", sodium) + " mg"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateChange(_ sender: UIDatePicker) {
        
        formatter.dateFormat = "dd-MM-yyyy"
        let today = formatter.string(from: datePick.date)
        let user = AuthenticateUser.getUID()
        let meals:[Meal] = LoadingData.shared.mealList
        
        DietaryPlanDataManagerFirebase.loadMealPlans(date: today, username: user){
            plan in
            
            var calories:Int = 0
            var carb:Double = 0.0
            var fat:Double = 0.0
            var protein:Double = 0.0
            var sodium:Double = 0.0
            
            //loop for calories and carbohydrates
            for i in 0..<plan.count{
                calories = Int(plan[i].calories!) + calories
                for x in 0..<meals.count{
                    if(plan[i].mealID == meals[x].mealID){
                        carb = Double(meals[x].carbohydrates!) + carb
                        fat = Double(meals[x].fat!) + fat
                        protein = Double(meals[x].protein!) + protein
                        sodium = Double(meals[x].sodium!) + sodium
                    }
                }
            }
            //loop end
            
            self.calories.text = calories.description + " Kcal"
            self.carbs.text = String(format: "%.2f", carb) + " g"
            self.fat.text = String(format: "%.2f", fat) + " g"
            self.protein.text = String(format: "%.2f", protein) + " g"
            self.sodium.text = String(format: "%.2f", sodium) + " mg"
        }
    }
}
