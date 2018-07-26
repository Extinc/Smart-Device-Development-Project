//
//  checkForHawker.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 26/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class checkForHawker: NSObject {
    
    static func loadHawkerWithMeal(meal: Meal, hawkers: [HawkerCentres]) -> [HawkerCentres] {
        var hawkerCentres: [HawkerCentres] = []
        let hawkerNumbers : String = meal.hawkercentres!
        let arrayOfNumbersString = hawkerNumbers.components(separatedBy: ", ")
        var arrayOfNumbers: [Int] = []
        
        for j in 0...arrayOfNumbersString.count - 1  {
            arrayOfNumbers[j] = Int(arrayOfNumbersString[j])!
        }
        
        for i in 0...hawkers.count - 1  {
            if(hawkers[i].hawkerID == arrayOfNumbers[i]) {
                hawkerCentres.append(hawkers[i])
            }
        }
        
        return hawkerCentres
    }

}
