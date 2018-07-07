//
//  MealPlan.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 21/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MealPlan: NSObject {
    var planID: Int?
    var username: String?
    var date: String?
    var mealID: Int?
    var mealName: String?
    var mealImage: String?
    var calories: Float?
    var isDiary: String?
    
    
    init(_ planID: Int ,_ username:String, _ date: String, _ mealID:Int, _ mealName: String, _ mealImage: String, _ calories: Float, _ isDiary: String) {
        self.planID = planID
        self.username = username
        self.date = date
        self.mealID = mealID
        self.mealName = mealName
        self.mealImage = mealImage
        self.calories = calories
        self.isDiary = isDiary
    }
    
}
