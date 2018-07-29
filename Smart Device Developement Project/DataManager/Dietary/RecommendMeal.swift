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
    
    
    static func createMealPlan(meals: [Meal], username: String, totalCalories: Int){
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
    
        
        
        for i in 0...planDays {
            date.day = date.day! + 1
            let fDate = NSCalendar.current.date(from: date)
            currentDate = dateFormatter.string(from: fDate!)
            makeNotiContent(planPreferences: preferences, notiDate: fDate!)
            
            if (planType == "Gluten Free"){
                plan = glutenFreePlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories))
            }
            else if (planType == "Dash") {
                plan = dashPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories))
            }
            else if (planType == "Keto") {
                plan = ketoPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories))
            }
            else if (planType == "Normal"){
                plan = normalPlan(meals: meals, planPreferences: preferences, date: currentDate, totalCalories: Float(totalCalories))
            }
          
            DietaryPlanDataManagerFirebase.createPlanData(mealPlanList: plan)
        }

        
    }
    
    
    static func dashPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float) -> [MealPlan] {
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
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            
        }
        
        
        
        return plan
    }
    
    static func ketoPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float) -> [MealPlan]{
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
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
        }
        return plan
    }
    
    static func glutenFreePlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float) -> [MealPlan] {
        
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
        //Append into Meal Plan List 
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
            
        }
        
        return plan
    }
    
    //Normal Plan
    static func normalPlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float) -> [MealPlan] {
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
        //Append into Meal Plan List
        for b in 0...mealListCount{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            let recipeImage = mealList[b].recipeImage
            
            
            plan.append(MealPlan(username, date, mealID!, mealName!, mealImage!, calories!, recipeImage! ,"No"))
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
    
    // MARK: - Notifcations
    static func makeNotiContent(planPreferences: UserPlanPreferences, notiDate: Date){
        var mealsinterval: Double = 0
        if(planPreferences.mealsperday == 1) {
            //Stop eating at 6pm
        }
        else if (planPreferences.mealsperday == 2){
            //Stop eating at 6pm
            mealsinterval = 8
        }
        else if (planPreferences.mealsperday == 3){
            //Stop eating at 6pm
            mealsinterval = 5
        }
        else if (planPreferences.mealsperday == 4) {
            //Stop eating at 7pm
            mealsinterval = 3.5
        }
        else if(planPreferences.mealsperday == 5){
            //Stop eating at 8pm
            mealsinterval = 3
        }
        else {
            //6 meals per day
            //Stop eating at 8pm
            mealsinterval = 2
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Meal Reminder"
        content.body = "Remember to follow the meal plan and don't miss your meals!"
        
        let unitFlags:Set<Calendar.Component> = [.minute,.hour,.second]
        var date = Calendar.current.dateComponents(unitFlags, from: notiDate)
        date.second = date.second! + 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        addNotification(trigger: trigger, content: content, identifier: "message.remindmeal")
    }
    
    static func addNotification(trigger: UNNotificationTrigger?, content: UNMutableNotificationContent, identifier: String){
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){
            (error) in
            if error != nil {
                print("error adding notification:\(error?.localizedDescription)")
            }
        }
    }
    
    
}
