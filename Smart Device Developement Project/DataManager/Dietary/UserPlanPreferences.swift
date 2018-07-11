//
//  UserPlanPreferences.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 25/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class UserPlanPreferences: NSObject {
    var username: String?
    var mealPlanType: String?
    var duration: String?
    var mealsperday: Int?
    var mealtiming: String?
    var reminders: String?
    var startDate: String?
    
    
    init(_ username: String,_ mealPlanType: String, _ duration: String, _ mealsperday: Int,_ mealtiming: String,_ reminders: String, _ startDate: String ){
        self.username = username
        self.mealPlanType = mealPlanType
        self.duration = duration
        self.mealsperday = mealsperday
        self.mealtiming = mealtiming
        self.reminders = reminders
        self.startDate = startDate
        
    }
}
