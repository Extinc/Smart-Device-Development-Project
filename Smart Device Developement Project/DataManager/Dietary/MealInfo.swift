//
//  MealInfo.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit


class MealInfo: NSObject {
    
    func GetInfo(food: String,
                 onComplete: ((_ : [foodData]) -> Void)?)
    {
        let APPLICATION_ID = "42f9c7f2"
        let APPLICATION_KEY = "a38a2ac0cfe3046b7a592c4723fb91ef"
        let foodName = food
        
        let url = "https://api.nutritionix.com/v1_1/search/\(foodName)?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat&appId=\(APPLICATION_ID)&appKey=\(APPLICATION_KEY)"
        print(url)
        HTTP.getJSON(url: url, onComplete:
            {
                json, response, error in
                    
                if error != nil
                {
                    return
                }
                let foodJson = json!

                let count  = foodJson["hits"].count
                let name  = foodJson["hits"][0]["fields"]["item_name"]
                print(name)
                
                var foodlist : [foodData] = []
                // Loop through each article, create a new News
                // object for each article and add it to our
                // list. //
                for i in 0 ..< count
                {
                    let foodField = foodJson["hits"][i]["fields"]
                    let food = foodData(
                        name: foodField["item_name"].string!,
                        calories: foodField["nf_calories"].string!,
                        fat: foodField["nf_total_fat"].string!)
                    
                    foodlist.append(food)
                }
                // Now we call the caller's onComplete method
                // so that the caller can process the data or // display it on the screen
                //
                onComplete?(foodlist)
            })
    }
}
