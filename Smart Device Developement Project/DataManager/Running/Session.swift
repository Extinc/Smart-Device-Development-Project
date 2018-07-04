//
//  Session.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 26/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Session: NSObject {
    
    var sessionID : Int?
    var currentdistance: Double?
    var totaldistance: Double?
    var finishdate: String?
    var totaltime: String?
    var lap1speed: String?
    var lap2speed: String?
    var lap3speed: String?
    var lap4speed: String?
    var lap5speed: String?
    var lap1estimateddistance: String?
    var lap2estimateddistance: String?
    var lap3estimateddistance: String?
    var lap4estimateddistance: String?
    var lap5estimateddistance: String?
    var lap1distance: String?
    var lap2distance: String?
    var lap3distance: String?
    var lap4distance: String?
    var lap5distance: String?
    var totalcaloriesburnt: Double?
    var progress: Int?
    var scheduleID: Int?
    var sessionComplete: Int?
    var lap1time: Double?
    var lap2time: Double?
    var lap3time: Double?
    var lap4time: Double?
    var lap5time: Double?
    
    init(_ scheduleID:Int,_ currentdistance:Double,_ totaldistance:Double,_ totaltime: String,_ finishdate:String,_ totalcaloriesburnt: Double)
    {
        self.currentdistance = currentdistance
        self.totaldistance = totaldistance
        self.finishdate = finishdate
        self.totalcaloriesburnt = totalcaloriesburnt
        self.totaltime = totaltime
        self.scheduleID = scheduleID
    }
    
    init(firstspeed lap1speed:String,secondspeed lap2speed:String,thirdspeed lap3speed:String,fourthspeed lap4speed:String,fivespeed lap5speed:String,_ sessionid:Int)
    {
        self.lap1speed = lap1speed
        self.lap2speed = lap2speed
        self.lap3speed = lap3speed
        self.lap4speed = lap4speed
        self.lap5speed = lap5speed
        self.sessionID = sessionid
    }
    init(firsttime lap1time:Double,secondtime lap2time:Double,thirdtime lap3time:Double,fourthtime lap4time:Double,fivetime lap5time:Double,_ sessionid:Int)
    {
        self.lap1time = lap1time
        self.lap2time = lap2time
        self.lap3time = lap3time
        self.lap4time = lap4time
        self.lap5time = lap5time
        self.sessionID = sessionid
    }
    
    init(firstestimate lap1estimateddistance:String, secondestimate lap2estimateddistance:String,thirdestimate lap3estimateddistance:String,fourthestimate lap4estimateddistance:String,fifthestimate lap5estimateddistance:String) {
        self.lap1estimateddistance = lap1estimateddistance
        self.lap2estimateddistance = lap2estimateddistance
        self.lap3estimateddistance = lap3estimateddistance
        self.lap4estimateddistance = lap4estimateddistance
        self.lap5estimateddistance = lap5estimateddistance
    }
    init(firstspeed lap1speed:String)
    {
        self.lap1speed = lap1speed
    }
    init(secondspeed lap2speed:String)
    {
        self.lap2speed = lap2speed
    }
    init(thirdspeed lap3speed:String)
    {
        self.lap3speed = lap3speed
    }
    init(fourthspeed lap4speed:String)
    {
        self.lap4speed = lap4speed
    }
    init(fivespeed lap5speed:String)
    {
        self.lap5speed = lap5speed
    }
    init(time totaltime:String,_ scheduleID:Int)
    {
        self.totaltime = totaltime
        self.scheduleID = scheduleID
    }
    init(firstdistance lap1distance:String,seconddistance lap2distance:String,thirddistance lap3distance:String,fourthdistance lap4distance:String,fifthdistance lap5distance:String,_ scheduleID:Int)
    {
        self.lap1distance = lap1distance
        self.lap2distance = lap2distance
        self.lap3distance = lap3distance
        self.lap4distance = lap4distance
        self.lap5distance = lap5distance
        self.scheduleID = scheduleID
    }
    init(scheduleid scheduleID:Int,totalcalories totalcaloriesburnt:Double)
    {
        self.scheduleID = scheduleID
        self.totalcaloriesburnt = totalcaloriesburnt
    }
    init(scheduleid scheduleID:Int,currentdistance currentdistance:Double)
    {
        self.scheduleID = scheduleID
        self.currentdistance = currentdistance
    }
    init(scheduleid scheduleID:Int,sessioncomplete sessionComplete:Int)
    {
        self.scheduleID = scheduleID
        self.sessionComplete = sessionComplete
    }
}
