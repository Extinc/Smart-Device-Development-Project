//
//  Recipe.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var mealID: Int?
    var recipeID: Int?
    var directions: String?
    var ingredients: String?
    var servingSize: String?
    
    init(_ mealID: Int, _ recipeID: Int, _ directions: String, _ ingredients: String, _ servingSize: String ){
        self.mealID = mealID
        self.recipeID = recipeID
        self.directions = directions
        self.ingredients = ingredients
        self.servingSize = servingSize 
    }

}
