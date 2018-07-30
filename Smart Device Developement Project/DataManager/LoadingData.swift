//
//  LoadingData.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 30/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class LoadingData: NSObject {

    var bmi:Double?
    var rcalories:Int = 0
    var weight:Double = 0.0
    var goals:Int = 0

    func loadData(completion: @escaping (Bool) -> ()){
        let dg = DispatchGroup()
        
        let workerQueue = DispatchQueue.global(qos: .userInitiated)
        workerQueue.async{
            dg.enter()
            NutrInfo().calReccCalories(){
                cal in
                self.rcalories = cal
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().calcBMI(){
                bmi in
                self.bmi = bmi
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().getWeight(){
                weight in
                self.weight = weight   
                dg.leave()
            }
            
            dg.enter()
            NutrInfo().getGoal(){
                goal in
                self.goals = goal
                dg.leave()
            }
            
            dg.wait()
            DispatchQueue.main.async {
                print(self.rcalories)
                print(self.bmi)
                print(self.weight)
                print(self.goals)
                completion(true)
            }
        }
        
    }
}
