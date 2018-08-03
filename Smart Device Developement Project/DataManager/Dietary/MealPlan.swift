//
//  MealPlan.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 21/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MealPlan: NSObject {

    var username: String?
    var planID: Int?
    var date: String?
    var mealID: Int?
    var mealName: String?
    var mealImage: String?
    var calories: Float?
    var recipeImage: String?
    var isDiary: String?
    
    
    
    init(_ username:String, _ planID:Int, _ date: String, _ mealID:Int, _ mealName: String, _ mealImage: String, _ calories: Float,_ recipeImage: String, _ isDiary: String) {
        self.username = username
        self.planID = planID
        self.date = date
        self.mealID = mealID
        self.mealName = mealName
        self.mealImage = mealImage
        self.calories = calories
        self.recipeImage = recipeImage
        self.isDiary = isDiary
    }
    
}
