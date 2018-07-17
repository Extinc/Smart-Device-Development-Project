//
//  Schedule.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    var scheduleId : Int?
    var startDate: String?
    var day: String?
    var trainingdistance: String?
    var numberoftimes: String?
    var progress: String?
    var forfeit: Int?
    var complete: Int?
    var userID: String?
    var eventstoresaved: String?
    var eventsaved: String?
    
    
    init(_ scheduleId:Int,_ startDate:String,_ day:String, trainingdistance:String,_ numberoftimes:String,_ progress:String,_ forfeit:Int,_ complete:Int,_ userID:String) {
        self.scheduleId = scheduleId
        self.startDate = startDate
        self.day = day
        self.trainingdistance = trainingdistance
        self.numberoftimes = numberoftimes
        self.progress = progress
        self.forfeit = forfeit
        self.complete = complete
        self.userID = userID
    }
    
 init(_ startDate:String,_ day:String,_ trainingdistance:String,_ numberoftimes:String,_ progress:String,_ userID:String)
 {
        self.startDate = startDate
        self.day = day
        self.trainingdistance = trainingdistance
        self.numberoftimes = numberoftimes
        self.progress = progress
        self.userID = userID 
    
}
    init(_ startDate:String,_ day:String,_ trainingdistance:String,_ numberoftimes:String,_ progress:String,_ userID:String,_ eventstoresaved:String,_ eventsaved:String)
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
    init(_ progress:String,_ scheduleId:Int)
    {
        self.progress = progress
        self.scheduleId = scheduleId
    }
    init(_ scheduleId:Int)
    {
        self.scheduleId = scheduleId
    }
    init(_ scheduleId:Int,_ startDate:String,_ day:String,_ trainingdistance:String,_ numberoftimes:String,_ progress:String,_ userID:String,_ eventstoresaved:String,_ eventsaved:String)
    {
    self.scheduleId = scheduleId
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
