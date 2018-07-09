//
//  RecommendMeal.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RecommendMeal: NSObject {
    
    
    static func createMealPlan(meals: [Meal], date: String, username: String){
        var plan: [MealPlan] = []
        let preferences: UserPlanPreferences = DietaryPlanDataManager.loadPreferences(username: username)[0]
        let planType = preferences.mealPlanType
        //let totalCalories: Float = Float(NutrInfo.calReccCalories())
        let totalCalories: Float = 2200
        if (planType == "Gluten Free"){
            plan = glutenFreePlan(meals: meals, planPreferences: preferences, date: date, totalCalories: totalCalories)
            
        }
        else {
            
        }
        
        
        DietaryPlanDataManagerFirebase.createPlanData(mealPlanList: plan)
    }
    
    static func getLastPlanID() -> Int{
        var planid: Int = 0
        return planid
    }
    
    static func veganPlan(ingredients: String, totalCalories: Float, meal: Meal) -> [Meal] {
        
        var plan: [Meal] = []
        
        //Check for ingredients
        if(ingredients.contains(""))
        {
            
        }
        
        return plan
    }
    
    static func glutenFreePlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String, totalCalories: Float) -> [MealPlan] {
        
        var plan: [MealPlan] = []
        var mealListBefore: [Meal] = meals
        var mealList: [Meal] = []
        let noIngredients = ["Wheat", "Wheat germ", "Rye", "Barley", "Bulgur", "Couscous", "Farina", "Graham flour", "Kamut Matzo", "Semolina", "Spelt", "Triticale"]
        let Count = mealListBefore.count - 1
        let ingredientsCount = noIngredients.count - 1
        var arrayOfMealID: [Int] = []
        var arrayOfMealIDAfterCalories: [Int] = []
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)
        
        //Check for ingredients
        for i in 0...Count {
            for j in 0...ingredientsCount{
                if(meals[i].ingredients?.contains(noIngredients[j]) == false ){
                    arrayOfMealID.append(mealListBefore[i].mealID!)
                    mealListBefore.remove(at: i)
                }
            }
        }
        
        //Check calories
        for k in 0...arrayOfMealID.count - 1 {
            if(meals[arrayOfMealID[k]].calories! <= eachMealCalories){
                arrayOfMealIDAfterCalories.append(meals[arrayOfMealID[k]].mealID!)
            }
        }
        
        //Randomly pick from meals that have satisfied conditions
        for a in 0...planPreferences.mealsperday! - 1 {
            let randomNumber = Int(arc4random_uniform(UInt32(arrayOfMealIDAfterCalories.count-1)))
            let mealId = arrayOfMealIDAfterCalories[randomNumber]
            arrayOfMealIDAfterCalories.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        //Append into Meal Plan List 
        for b in 0...mealList.count - 1{
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].mealImage
            let calories = mealList[b].calories
            var planID = 1
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, "No"))
            planID += 1
            
        }
        
        return plan
    }
    
    
    
}
