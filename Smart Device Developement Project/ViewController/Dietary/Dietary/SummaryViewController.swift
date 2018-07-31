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

    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.dateFormat = "dd-MM-yyyy"
        let today = formatter.string(from: date)
        let user = AuthenticateUser.getUID()
        let meals:[Meal] = LoadingData.shared.mealList
        
        DietaryPlanDataManagerFirebase.loadMealPlans(date: today, username: user){
            plan in
            var rcalories = LoadingData.shared.rcalories
            var icalories:Int = 0
            
            //today carb intake
            let carbRecc = Double((rcalories/100)*60)
            var carbIntake:Double = 0.0
            
            //loop for today calories and carbohydrates
            for i in 0..<plan.count{
                icalories = Int(plan[i].calories!) + icalories
                for x in 0..<meals.count{
                    if(plan[i].mealID == meals[x].mealID){
                        carbIntake = Double(meals[x].carbohydrates!) + carbIntake
                    }
                }
            }
            
            //calculate and display
            let intake: Double = Double(icalories)
            let calories = Double(LoadingData.shared.rcalories)
            let percent = (intake/calories)*100
            let angle = (360/100)*percent

            
            //carbohydrates
            let C_percent = (carbIntake/carbRecc)*100
            let C_angle = (360/100)*C_percent

        }
    }

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
