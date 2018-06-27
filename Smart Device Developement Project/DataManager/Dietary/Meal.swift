//
//  Meal.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Meal: NSObject {
    var mealID: Int?
    var name: String?
    var calories: Float?
    var carbohydrates: Float?
    var protein: Float?
    var fat: Float?
    var sodium: Float?
    
    init(_ mealID: Int, _ name: String, _ calories: Float, _ carbohydrates: Float, _ protein: Float, _ fat: Float, _ sodium: Float ){
        self.mealID = mealID
        self.name = name
        self.calories = calories
        self.carbohydrates = carbohydrates
        self.protein = protein
        self.fat = fat
        self.sodium = sodium
        
    }
}
