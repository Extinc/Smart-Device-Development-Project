//
//  RecommendMeal.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 4/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RecommendMeal: NSObject {
    var ingredients: String = ""
    var totalCalories: Float = 0
    var mealPlan = [MealPlan("","",0,0,0,"","","")]
    var meal = Meal(0,"",0,0,0,0,0)
    var planPreferences = UserPlanPreferences("","","","",0,"","",0)
    static func veganPlan(ingredients: String, totalCalories: Float, meal: Meal) -> [Meal] {
        
        var plan: [Meal] = []
        
        //Check for ingredients
        if(ingredients.contains(""))
        {
            
        }
        
        return plan
    }
    
    static func glutenFreePlan(totalCalories: Float, meals: [Meal], recipes: [Recipe], planPreferences: UserPlanPreferences) -> [Meal] {
        let plan: [Meal] = []
        let noIngredients = ("Wheat", "Wheat germ", "Rye", "Barley", "Bulgur", "Couscous", "Farina", "Graham flour", "Kamut Matzo", "Semolina", "Spelt", "Triticale")
        let count = meals.count
        var getIndex:Int = -1
        let eachMealCalories: Float = planPreferences.totalCaloriesPerDay! / (planPreferences.mealsperday! as! Float)
        
        
        for i in 0...count {
            
            //Check for ingredients
            if(recipes[i].ingredients?.contains(noIngredients.0) == false ){
                
                
                
            }
        }
        
        
        
        return plan
    }
    
    
    
}
