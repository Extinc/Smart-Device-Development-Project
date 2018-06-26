//
//  Schedule.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 25/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    
    var scheduleId: Int?
    var startDate : String?
    var day: String?
    var trainingdistance: String?
    var numberoftimes: String?
    var progress : String?
    var eventstoresaved : String?
    var eventsaved : String?
    var userID:String
    
    init(_ startDate:String,_ day:String,_ trainingdistance:String,_ numberoftimes:String,_ progress:String,_ userID:String, _ eventstoresaved:String,_ eventsaved:String)
    {
        self.startDate = startDate
        self.day = day
        self.trainingdistance = trainingdistance
        self.numberoftimes = numberoftimes
        self.progress = progress
        self.userID = userID
        self.eventstoresaved = eventstoresaved
        self.eventsaved = eventsaved
    }
    


}
