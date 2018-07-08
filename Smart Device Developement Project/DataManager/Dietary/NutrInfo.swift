//
//  NutrInfo.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class NutrInfo: NSObject {
    
    var height = 1.71 //: Double?
    var weight = 80.0 //: Double?
    var BMI: Double = 0.0
    
    func calcBMI() -> Double {
        
        /*let ref = FirebaseDatabase.Database.database().reference().child("Profile/")
         
         ref.observeSingleEvent(of: .value,
         with: { (snapshot) in
         for record in snapshot.children
         {
         let r = record as! DataSnapshot
         self.height = r.childSnapshot(forPath: "height").value as? Double)!
         self.weight = (r.childSnapshot(forPath: "weight").value as? Double)!
         }
         })*/
        print(height)
        print(weight)
        BMI = weight / (height * height)
        let x = Double(BMI * 100).rounded() / 100
        print("BMI:",x)

        return x
    }
    
    func calReccCalories() -> Int {
        let b1 = 13.7516 * 90.0
        let b2 = 5.0033 * 170
        let b3 = 6.7550 * 20
        let recc = 66.4730 + b1 + b2 - b3
        let calories = Int(recc.rounded())
        
        return calories;
    }

}
