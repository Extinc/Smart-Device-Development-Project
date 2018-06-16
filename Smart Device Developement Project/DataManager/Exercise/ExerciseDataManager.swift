//
//  ExerciseDataManager.swift
//  TestApp
//
//  Created by lim kei yiang on 14/6/18.
//  Copyright © 2018 NYP. All rights reserved.
//

import UIKit

class ExerciseDataManager: NSObject{
    // Token For wger.de/api/v2/exercise/
    let AuthorizationToken = "Token 1ca4117d3a597c00930fe0ac19c3ab8ffaef2557"
    let apiLink = "https://wger.de/api/v2"
    class func getJSON(onComplete: ((_ : [Exercise]) -> Void)?){
        //let AuthorizationToken = "Token 1ca4117d3a597c00930fe0ac19c3ab8ffaef2557"
        var exerciseList: [Exercise] = []
        
        HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercise/", token: ExerciseDataManager.init().AuthorizationToken) {
            (json1, response1, error1) in
            if error1 != nil{
                return
            }
            
            HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercise/&limit=\(json1!["count"].int!)", token: ExerciseDataManager.init().AuthorizationToken) {
                (json, response, error) in
                if error != nil{
                    return
                }
                let numResults: Int = json!["results"].count
                
                for j in 0...numResults{
                    //exerciseList.append(Exercise(id: , name: <#T##String#>, musclesPri: <#T##[Int]#>, musclesSec: <#T##[Int]#>, equipId: <#T##[Int]#>))
                    if json!["results"][j]["id"].int != nil{
                        let id: Int = json!["results"][j]["id"].int!
                        let name: String = json!["results"][j]["name"].string!
                        let muscPri: [Int] = json!["results"][j]["muscles"].arrayObject as! [Int]
                        let muscSec: [Int] = json!["results"][j]["muscles_secondary"].arrayObject as! [Int]
                        let equipment: [Int] = json!["results"][j]["equipment"].arrayObject as! [Int]
                        let category: Int = json!["results"][j]["category"].int!
                        exerciseList.append(Exercise(id: id, name: name, musclesPri: muscPri, musclesSec: muscSec, equipId: equipment, category: category))
                    }
                }
                print(json!)
                onComplete?(exerciseList)
            }
        }

    }
    
    class func getExerciseCategory(onComplete: ((_ : [ExerciseCategory]) -> Void)?){
        var ecList: [ExerciseCategory] = []
        HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercisecategory", token: ExerciseDataManager.init().AuthorizationToken) {
            (json, response, error) in
            if error != nil{
                return
            }
            let numResults: Int = json!["results"].count
            
            for j in 0...numResults{
                if json!["results"][j]["id"].int != nil{
                    let id: Int = json!["results"][j]["id"].int!
                    let name: String = json!["results"][j]["name"].string!
                    ecList.append(ExerciseCategory(id: id, name: name))
                }
            }
            print(json!)
            onComplete?(ecList)
        }
    }
    
    
}

