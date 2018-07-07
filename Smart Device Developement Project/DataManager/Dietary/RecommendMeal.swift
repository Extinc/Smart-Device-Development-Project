//
//  RecommendMeal.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RecommendMeal: NSObject {
    
    static func mealPlanTypeSelect (planType: String, meals: [Meal], planPreferences: UserPlanPreferences, date: String ) {
        if (planType == "Gluten Free"){
            glutenFreePlan(meals: meals, planPreferences: planPreferences, date: date)
        }
        else {
            
        }
    }
    static func veganPlan(ingredients: String, totalCalories: Float, meal: Meal) -> [Meal] {
        
        var plan: [Meal] = []
        
        //Check for ingredients
        if(ingredients.contains(""))
        {
            
        }
        
        return plan
    }
    
    static func glutenFreePlan(meals: [Meal], planPreferences: UserPlanPreferences, date: String) -> [MealPlan] {
        
        var plan: [MealPlan] = []
        var mealList: [Meal] = []
        let noIngredients = ["Wheat", "Wheat germ", "Rye", "Barley", "Bulgur", "Couscous", "Farina", "Graham flour", "Kamut Matzo", "Semolina", "Spelt", "Triticale"]
        let count = meals.count
        let ingredientsCount = noIngredients.count
        var getIndex:Int = -1
        var arrayOfMealID: [Int] = []
        var arrayOfMealIDAfterCalories: [Int] = []
        let totalCalories: Float = 1800
        let eachMealCalories: Float = totalCalories / Float(planPreferences.mealsperday!)
        
        //DietaryPlanFirebase.loadMeals()
        
        //Check for ingredients
        for i in 0...count {
            for j in 0...ingredientsCount{
                if(meals[i].ingredients?.contains(noIngredients[j]) == false ){
                    arrayOfMealID.append(meals[i].mealID!)
                }
            }
        }
        
        //Check calories
        for k in 0...arrayOfMealID.count {
            if(meals[arrayOfMealID[k]].calories! <= eachMealCalories){
                arrayOfMealIDAfterCalories.append(meals[arrayOfMealID[k]].mealID!)
                //beforeRandomMeal.append(meals[arrayOfMealID[k]])
            }
        }
        
        //Randomly pick from meals that have satisfied condition
        for a in 0...planPreferences.mealsperday! {
            let randomNumber = Int(arc4random_uniform(UInt32(arrayOfMealIDAfterCalories.count-1)))
            let mealId = arrayOfMealIDAfterCalories[randomNumber]
            arrayOfMealIDAfterCalories.remove(at: randomNumber)
            mealList.append(meals[mealId])
        }
        
        //Append into Meal Plan List
        for b in 0...mealList.count {
            let username = "1"
            let mealID = mealList[b].mealID
            let mealName = mealList[b].name
            let mealImage = mealList[b].image
            let calories = mealList[b].calories
            let planID = 1
            
            plan.append(MealPlan(planID, username, date, mealID!, mealName!, mealImage!, calories!, "No"))
            
        }
        
        return plan
    }
    
    
    
}
