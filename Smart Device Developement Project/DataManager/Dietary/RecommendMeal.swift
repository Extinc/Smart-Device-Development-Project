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
    
    
    static func createMealPlan(meals: [Meal], username: String, pID: Int, totalCalories: Int){
        var plan: [MealPlan] = []
        let preferences: UserPlanPreferences = DietaryPlanDataManager.loadPreferences(username: username)[0]
        let planType = preferences.mealPlanType!
        let planDays: Int = Int(preferences.duration!)!
        var dateComponent = DateComponents()
        let daysToAdd = 1
        var currentDate = preferences.startDate!
        
        for i in 0...planDays {
            
            dateComponent.day = i
            dateComponent.month = 0
            dateComponent.year = 0
            
            
            if (planType == "Gluten Free"){
                plan = glutenFreePlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), pID: pID)
            }
            else if (planType == "Dash") {
                plan = dashPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), pID: pID)
            }
            else if (planType == "Keto") {
                plan = ketoPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), pID: pID)
            }
            else if (planType == "Normal"){
                plan = normalPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories), pID: pID)
            }
          
            DietaryPlanDataManagerFirebase.createPlanData(mealPlanList: plan)
        }

        
    }
    
    static func getLastPlanID() -> Int{
        var planid: Int = 0
        return planid
    }
    
    static func dashPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, pID: Int) -> [MealPlan] {
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
        var planID: Int = pID + 1
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            planID = planID + 1
            
        }
        
        
        
        return plan
    }
    
    static func ketoPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, pID: Int) -> [MealPlan]{
        var plan: [MealPlan] = []
        let maxCarbs: Float = 50
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
        var planID: Int = pID + 1
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            planID = planID + 1
        }
        return plan
    }
    
    static func glutenFreePlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, pID : Int ) -> [MealPlan] {
        
        var plan: [MealPlan] = []
        var mealList: [Meal] = []
        let noIngredients = ["Wheat", "Wheat germ", "Rye", "Barley", "Bulgur", "Couscous", "Farina", "Graham flour", "Kamut Matzo", "Semolina", "Spelt", "Triticale", "Soy Sauce", "Roux"]
        let Count = meals.count - 1
        let ingredientsCount = noIngredients.count - 1
        var arrayOfMealIndex: [Int] = []
        var arrayOfMealIDAfterCalories: [Int] = []
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)

        
        //Check for ingredients
        for i in 0...Count {
            for j in 0...ingredientsCount{
                if(meals[i].ingredients?.contains(noIngredients[j]) == false ){
                    if (arrayOfMealIndex.count > 0) {
                        for m in 0...arrayOfMealIndex.count{
                            if(arrayOfMealIndex.contains(meals[i].mealID!) == false) {
                                arrayOfMealIndex.append(i)
                                break
                            }
                            else {
                                break 
                            }
                        }
                    }
                    else {
                        arrayOfMealIndex.append(i)
                    }
                }
            }
        }
        
        let arrayCount: Int = arrayOfMealIndex.count - 1
        
        //Check calories
        for k in 0...arrayCount {
            if(meals[arrayOfMealIndex[k]].calories! <= eachMealCalories){
                arrayOfMealIDAfterCalories.append(meals[arrayOfMealIndex[k]].mealID!)
            }
        }
        
        let mealsperdayCount: Int = planPreferences.mealsperday! - 1
        
        //Randomly pick from meals that have satisfied conditions
        for a in 0...mealsperdayCount {
            let randomNumber = Int(arc4random_uniform(UInt32(arrayOfMealIDAfterCalories.count-1)))
            let mealId = arrayOfMealIDAfterCalories[randomNumber]
            arrayOfMealIDAfterCalories.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        let mealListCount: Int = mealList.count - 1
        var planID: Int = pID + 1
        //Append into Meal Plan List 
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            planID = planID + 1
            
        }
        
        return plan
    }
    
    //Normal Plan
    static func normalPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float, pID: Int) -> [MealPlan] {
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
        var planID: Int = pID + 1
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            planID = planID + 1
        }
        
        return plan
    }
    
    static func getSimilarMeal(meal: Meal) -> [Meal]{
        var newMeals: [Meal] = []
        
        
        return newMeals
    }
    
    static func makeNotiContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        return content
    }
    
    
}
