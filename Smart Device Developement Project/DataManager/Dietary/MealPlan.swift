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
    
    init(username:String, date: String, mealID:Int, mealNo:Int, planID: Int) {
        self.username = username
        self.date = date
        self.mealID = mealID
        self.mealNo = mealNo
        self.planID = planID
        
    }
    
}
