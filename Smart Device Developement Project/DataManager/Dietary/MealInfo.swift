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
        let r = RapidConnect(projectName: "", andToken: "")
        
        r?.callPackage("Nutritionix",
                       block: "getFoodsNutrients",
                       withParameters: ["applicationSecret" : "a38a2ac0cfe3046b7a592c4723fb91ef", "foodDescription" : "Chicken Rice", "applicationId" : "42f9c7f2"],
                        success: { (data) in
                            // returned data
                            var d = data!
                            var d0 = d[0] as! [String: Any]
                            var d0_foods = d0["foods"]!
                            print(d0_foods)
                           // var d0_foods_0 = d0_foods[0] as! [String: Any]
                            //var d0_nf_sodium = d0_foods_0["nf_sodium"]!
                            //print(d0_nf_sodium)
                            
                            //print(d[0]["foods"][0]["nf_sodium"])
                        },
                        failure: { (error) in
                            
                        })
    }

}
