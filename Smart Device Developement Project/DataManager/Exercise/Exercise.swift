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
    var equipment: Int
    var imageLink: [String] = []
    var muscleImg: String?
    var desc: String?
    var type: String?
    var level: String?
    var category: Int?
    var videoLink: String?
    
    init(id:Int, name: String, equipment: Int, desc: String, category: Int, videoLink: String, imageLink: [String], type: String, muscleImg: String, level: String) {
        self.id = id
        self.name = name
        self.equipment = equipment
        self.imageLink = imageLink
        self.desc = desc
        self.category = category
        self.videoLink = videoLink
        self.type = type
        self.muscleImg = muscleImg
        self.level = level
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

class Equipment: NSObject {
    var id: Int?
    var name: String?
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

class ExerciseCategory: NSObject {
    var id: Int?
    var name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

