//
//  MealInfo.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MealInfo: NSObject {
    
    static func insertInfo(mealplan: MealPlan)
    {
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO MealPlan(mealid, name, calories, carbohydrates, protein, fat, sodium)" + "VALUE (?, ?, ?, ?, ?, ?, ?)",
                                        parameters: [
                                            "1",
                                            "Chicken Rice",
                                            "
            ]
        )
        
        
        
    }

}
