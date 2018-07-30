//
//  LoadingData.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 30/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class LoadingData: NSObject {
    
    // Singleton
    static var _shared : LoadingData?
    static var shared : LoadingData
    {
        get
        {
            if _shared == nil
            {
                _shared = LoadingData()
            }
            return _shared!
        }
    }

    var bmi:Double = 0.0
    var rcalories:Int = 0
    var weight:Double = 0.0
    var goals:Int = 0
    var mealList: [Meal] = []
    var mealPlan: [MealPlan] = []
    
    let date = Date()
    let formatter = DateFormatter()

    func loadData(completion: @escaping (Bool) -> ()){
        formatter.dateFormat = "dd-MM-yyyy"
        let today = formatter.string(from: date)
        
        let user = AuthenticateUser.getUID()
        
        let dg = DispatchGroup()
        
        let workerQueue = DispatchQueue.global(qos: .userInitiated)
        workerQueue.async{
            
            dg.enter()
            NutrInfo().calReccCalories(){
                cal in
                self.rcalories = cal
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().calcBMI(){
                bmi in
                self.bmi = bmi
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().getWeight(){
                weight in
                self.weight = weight   
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().getGoal(){
                goal in
                self.goals = goal
                dg.leave()
            }
            
            dg.enter()
            DietaryPlanDataManagerFirebase.loadMeals(){
                meals in
                self.mealList = meals
                dg.leave()
            }
            
            dg.enter()
            DietaryPlanDataManagerFirebase.loadMealPlans(date: today, username: user){
                plan in
                self.mealPlan = plan
                dg.leave()
            }
            
            dg.wait()
            DispatchQueue.main.async {
                completion(true)
            }
        }
        
    }
}
