//
//  MealType.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 12/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MealType {
    var mealType = ""
    var mealTypeDescription = ""
    var image = ""
    
    init(_ mealType: String, _ mealTypeDescription: String, _ image: String)
    {
        self.mealType = mealType
        self.mealTypeDescription = mealTypeDescription
        self.image = image
    }
}
