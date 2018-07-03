//
//  MealInfo.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit


class MealInfo: NSObject {
    
    func GetInfo()
    {
        let APPLICATION_ID = "42f9c7f2"
        let APPLICATION_KEY = "a38a2ac0cfe3046b7a592c4723fb91ef"
        let foodName = "Taco"
        
        let url = "https://api.nutritionix.com/v1_1/search/\(foodName)?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat&appId=\(APPLICATION_ID)&appKey=\(APPLICATION_KEY)"
        HTTP.getJSON(url: url, onComplete:
            {
                json, response, error in
                    
                if error != nil
                {
                    return
                }
                let foodData = json!

                let count = foodData["total_hits"]
                print(count)
            })
    }
}
