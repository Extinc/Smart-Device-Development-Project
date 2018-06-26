//
//  Meal.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 23/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Meal {
    var mealName = ""
    var mealCalories = ""
    var imagePath = ""
    
    init(_ mealName: String, _ mealCalories: String, _ imagePath: String)
    {
        self.mealName = mealName
        self.mealCalories = mealCalories
        self.imagePath = imagePath
    }
}
