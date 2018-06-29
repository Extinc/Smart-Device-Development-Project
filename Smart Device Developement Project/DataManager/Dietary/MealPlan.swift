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
    var date: String?
    var mealID: Int?
    var mealNo: Int?
    var planID: Int?
    var mealName: String?
    var mealImage: String?
    var calories: String?
    
    
    init(_ username:String, _ date: String, _ mealID:Int, _ mealNo:Int, _ planID: Int, _ mealName: String, _ mealImage: String, _ calories: String) {
        self.username = username
        self.date = date
        self.mealID = mealID
        self.mealNo = mealNo
        self.planID = planID
        self.mealName = mealName
        self.mealImage = mealImage
        self.calories = calories
        
    }
    
}
