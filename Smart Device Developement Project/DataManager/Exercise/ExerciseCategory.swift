//
//  ExerciseCategory.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 16/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ExerciseCategory: NSObject {
    var id: Int?
    var name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
