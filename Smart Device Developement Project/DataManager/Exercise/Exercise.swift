//
//  Exercise.swift
//  TestApp
//
//  Created by lim kei yiang on 14/6/18.
//  Copyright © 2018 NYP. All rights reserved.
//

import UIKit

class Exercise: NSObject {
    var id: Int?
    var name: String?
    var musclesPri: [Int] = []
    var musclesSec: [Int] = []
    var equipId: [Int] = []
    var desc: String?
    var category: Int?
    
    init(id:Int, name: String, musclesPri: [Int], musclesSec: [Int], equipId: [Int], desc: String,category: Int) {
        self.id = id
        self.name = name
        self.musclesPri = musclesPri
        self.musclesSec = musclesSec
        self.equipId = equipId
        self.desc = desc
        self.category = category
    }
}

class ExerciseInfo: NSObject {
    
}

class ExerciseImage: NSObject {
    var id: Int?
    var imageurl: String?
    var exerciseID: Int?
    
    init(id: Int, imageurl: String, exerciseID: Int) {
        self.id = id
        self.imageurl = imageurl
        self.exerciseID = exerciseID
    }
}
