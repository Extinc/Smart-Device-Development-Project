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
    var totalcaloriesburnt: String?
    var progress: Int?
    var scheduleID: Int?
    
    init(_ currentdistance:Double,_ totaldistance:Double,_ finishdate:String,_ totalcaloriesburnt: String,_ progress:Int,_ totaltime:String,_ scheduleID:Int)
    {
        self.currentdistance = currentdistance
        self.totaldistance = totaldistance
        self.finishdate = finishdate
        self.totalcaloriesburnt = totalcaloriesburnt
        self.progress = progress
        self.totaltime = totaltime
        self.scheduleID = scheduleID
    }
    
    init(firstspeed lap1speed:String,secondspeed lap2speed:String,thirdspeed lap3speed:String,fourthspeed lap4speed:String,fivespeed lap5speed:String)
    {
        self.lap1speed = lap1speed
        self.lap2speed = lap2speed
        self.lap3speed = lap3speed
        self.lap4speed = lap4speed
        self.lap5speed = lap5speed
    }
    
    init(firstestimate lap1estimateddistance:String, secondestimate lap2estimateddistance:String,thirdestimate lap3estimateddistance:String,fourthestimate lap4estimateddistance:String,fifthestimate lap5estimateddistance:String) {
        self.lap1estimateddistance = lap1estimateddistance
        self.lap2estimateddistance = lap2estimateddistance
        self.lap3estimateddistance = lap3estimateddistance
        self.lap4estimateddistance = lap4estimateddistance
        self.lap5estimateddistance = lap5estimateddistance
    }
    
    init(firstdistance lap1distance:String,seconddistance lap2distance:String,thirddistance lap3distance:String,fourthdistance lap4distance:String,fifthdistance lap5distance:String)
    {
        self.lap1distance = lap1distance
        self.lap2distance = lap2distance
        self.lap3distance = lap3distance
        self.lap4distance = lap4distance
        self.lap5distance = lap5distance
    }
}
