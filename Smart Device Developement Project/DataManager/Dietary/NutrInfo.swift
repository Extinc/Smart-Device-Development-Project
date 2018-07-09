//
//  NutrInfo.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NutrInfo: NSObject {

    var height: Double = 0.0
    var weight: Double = 0.0
    var BMI: Double = 0.0
    
    func calcBMI() -> Double {
        
        //var user = Auth.auth()?.currentUser?.uid
        var ref: DatabaseReference
        let user = "dQsolOJTwjNSaGiEfMEnBObUkXH3"
        ref = Database.database().reference().child("Profile").child(user)
        
        ref.observeSingleEvent(of: .value,
                               with: { (snapshot) in
                                let height = (snapshot.childSnapshot(forPath: "height").value as? String)!
                                let weight = (snapshot.childSnapshot(forPath: "weight").value as? String)!
                                let h = Double(height) ?? 0.0
                                let w = Double(weight) ?? 0.0
                                self.height = h
                                self.weight = w
                                let h1 = h/100
                                let BMI = w / (h1 * h1)
                                let x = Double(BMI * 100).rounded() / 100
                                print("BMI:",x)
                                self.BMI = BMI
        })
        
        return self.BMI
    }
    
    func calReccCalories() -> Int {
        let b1 = 13.7516 * height
        let b2 = 5.0033 * weight
        let b3 = 6.7550 * 20
        let recc = 66.4730 + b1 + b2 - b3
        let calories = Int(recc.rounded())
        
        return calories;
    }

}
