//
//  RecommendMeal.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import UserNotifications

class RecommendMeal: NSObject {
    
    
    static func createMealPlan(meals: [Meal], username: String, totalCalories: Int, planid: Int){
        var plan: [MealPlan] = []
        let preferences: UserPlanPreferences = DietaryPlanDataManager.loadPreferences(username: username)[0]
        let planType = preferences.mealPlanType!
        let planDays: Int = Int(preferences.duration!)!

        let daysToAdd = 1
        let bFormatDate = preferences.startDate!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var aFormatDate = dateFormatter.date(from: bFormatDate)
        
        var currentDate = ""
        let unitFlags:Set<Calendar.Component> = [.day, .month, .year, .hour]
        var date = Calendar.current.dateComponents(unitFlags, from: aFormatDate!)
    
        
        
        for i in 0...planDays - 1 {
            if (i != 0) {
                date.day = date.day! + 1
            }
            else {
                //remain same day
            }
            
            let fDate = NSCalendar.current.date(from: date)
            currentDate = dateFormatter.string(from: fDate!)
            
            if (planType == "Dash") {
                plan = dashPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), planID: planid)
            }
            else if (planType == "Keto") {
                plan = ketoPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), planID: planid)
            }
            else if (planType == "Normal"){
                plan = normalPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), planID: planid)
            }
          
            DietaryPlanDataManagerFirebase.createPlanData(mealPlanList: plan)
        }

        
    }
    
    
    static func dashPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, planID: Int) -> [MealPlan] {
        var plan: [MealPlan] = []
        let maxSodium: Float = 1500
        let sodiumPerMeal: Float = maxSodium / Float(planPreferences.mealsperday!)
        let Count = meals.count - 1
        var mealIDBefore: [Int] = []
        var mealList: [Meal] = []
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)
        
        //check if over calories & sodium amount
        for i in 0...Count {
            if(meals[i].calories! <= eachMealCalories) {
                if(meals[i].sodium! <= sodiumPerMeal) {
                    mealIDBefore.append(i)
                }
            }
        }
        
        for a in 0...planPreferences.mealsperday! - 1 {
            let randomNumber = Int(arc4random_uniform(UInt32(mealIDBefore.count-1)))
            let mealId = mealIDBefore[randomNumber]
            mealIDBefore.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        let mealListCount: Int = mealList.count - 1
        var planid = planID
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = planPreferences.username!
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            planid += 1
            
            plan.append(MealPlan(username, planid, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No", "Dash", 1))
            
        }
        
        
        
        return plan
    }
    
    static func ketoPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, planID: Int) -> [MealPlan]{
        var plan: [MealPlan] = []
        let maxCarbs: Float = 150
        let carbsPerMeal: Float = maxCarbs / Float(planPreferences.mealsperday!)
        let Count = meals.count - 1
        var mealIDBefore: [Int] = []
        var mealList: [Meal] = []
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)
        
        //check if over calories & sodium amount
        for i in 0...Count {
            if(meals[i].calories! <= eachMealCalories) {
                if(meals[i].carbohydrates! <= carbsPerMeal) {
                    mealIDBefore.append(i)
                }
            }
        }
        
        for a in 0...planPreferences.mealsperday! - 1 {
            let randomNumber = Int(arc4random_uniform(UInt32(mealIDBefore.count-1)))
            let mealId = mealIDBefore[randomNumber]
            mealIDBefore.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        let mealListCount: Int = mealList.count - 1
        var planid = planID
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = planPreferences.username!
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            planid += 1
            plan.append(MealPlan(username,planid, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No", "Ketogenic", 1))
        }
        return plan
    }
    
    //Normal Plan
    static func normalPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, planID: Int) -> [MealPlan] {
        var plan: [MealPlan] = []
       
        let Count = meals.count - 1
        var mealIDBefore: [Int] = []
        var mealList: [Meal] = []
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)
        
        //check if over calories & sodium amount
        for i in 0...Count {
            if(meals[i].calories! <= eachMealCalories) {
                    mealIDBefore.append(i)
            }
        }
        
        for a in 0...planPreferences.mealsperday! - 1 {
            let randomNumber = Int(arc4random_uniform(UInt32(mealIDBefore.count-1)))
            let mealId = mealIDBefore[randomNumber]
            mealIDBefore.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        let mealListCount: Int = mealList.count - 1
        var planid = planID
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = planPreferences.username!
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            planid += 1
            plan.append(MealPlan(username, planid, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No", "Normal", 1))
        }
        
        return plan
    }
    
    static func getSimilarMeal(meal: Meal, meals: [Meal]) -> [Meal]{
        var newMeals: [Meal] = []
        for i in 0...meals.count - 1 {
            if(meal.calories == meals[i].calories || (meals[i].calories?.isLess(than: meal.calories!))!){
                newMeals.append(meals[i])
            }
        }
        
        return newMeals
    }
    
    
    
    
}
