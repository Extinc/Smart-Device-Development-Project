//
//  DietaryCreateData.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 5/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DietaryCreateData: NSObject {

    //Load Meal "table"
    static func loadMeals(onComplete: @escaping ([Meal]) -> Void) {
        //Create empty list
        var mealList : [Meal] = []
        let ref = FirebaseDatabase.Database.database().reference().child("Meal/")
        // Load full list of movies and execute "with" closure once, when download is complete
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                for record in snapshot.children {
                    let r = record as! DataSnapshot
                    mealList.append(Meal(Int(r.key)!,
                                         r.childSnapshot(forPath: "name").value as! String,
                                         r.childSnapshot(forPath: "calories").value as! Float,
                                         r.childSnapshot(forPath: "carbohydrates").value as! Float,
                                         r.childSnapshot(forPath: "protein").value as! Float,
                                         r.childSnapshot(forPath: "fat").value as! Float,
                                         r.childSnapshot(forPath: "sodium").value as! Float
                                         ))
                }
              onComplete(mealList)
        })
    }
    
    //Create / Update
    static func createData() {
        let ref1 = FirebaseDatabase.Database.database().reference().child("Meal/\(1)")
        ref1.setValue([
            "name" : "Chicken Rice",
            "calories" : "524.72",
            "carbohydrates" : "64.47",
            "protein" : "21.78",
            "fat" : "19.75",
            "sodium" : "1112.23"
            ]
        )
        
        let ref2 = FirebaseDatabase.Database.database().reference().child("Meal/\(2)")
        ref2.setValue([
            "name" : "Black Carrot Cake",
            "calories" : "556.47",
            "carbohydrates" : "65.77",
            "protein" : "13.16",
            "fat" : "26.74",
            "sodium" : "1937.08"
            ])
        
        let ref3 = FirebaseDatabase.Database.database().reference().child("Meal/\(3)")
        ref3.setValue([
            "name" : "Laksa",
            "calories" : "695.5",
            "carbohydrates" : "57.85",
            "protein" : "27.3",
            "fat" : "39.65",
            "sodium" : "7904"
            ])
        
        let ref4 = FirebaseDatabase.Database.database().reference().child("Meal/\(4)")
        ref4.setValue([
            "name" : "Prawn Aglio Olio",
            "calories" : "408.32",
            "carbohydrates" : "64.03",
            "protein" : "17.4",
            "fat" : "9.28",
            "sodium" : "786.48"
            ])
        
        
    }
    
}
