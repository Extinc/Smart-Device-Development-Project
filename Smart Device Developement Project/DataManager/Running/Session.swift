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
    var totalcaloriesburnt: Double?
    var totalspeed: Double?
    
    var lap1speed: String?
    var lap2speed: String?
    var lap3speed: String?
    var lap4speed: String?
    var lap5speed: String?
    var lap1distance: String?
    var lap2distance: String?
    var lap3distance: String?
    var lap4distance: String?
    var lap5distance: String?
    var userID:String?
    
    var progress: Int?
    var scheduleID: Int?
    var sessionComplete: Int?
    var lap1time: Double?
    var lap2time: Double?
    var lap3time: Double?
    var lap4time: Double?
    var lap5time: Double?
    
    var Alltime: [String]?
    var Alldistance: [String]?
    var month: String?
    var totalfinishdate: [String]?
    var AllSessionID: [Int]?
    var AllDistance: [Double]?
    var allTotalTime : [String]?
    var expanded: Bool!
    var rangeoflongitude: String?
    var rangeoflatitude: String?
    
    init(_ scheduleID:Int,_ currentdistance:Double,_ totaldistance:Double,_ totaltime: String,_ finishdate:String,_ totalcaloriesburnt: Double,_ month: String,_ userID:String)
    {
        self.currentdistance = currentdistance
        self.totaldistance = totaldistance
        self.finishdate = finishdate
        self.totalcaloriesburnt = totalcaloriesburnt
        self.totaltime = totaltime
        self.scheduleID = scheduleID
        self.month = month
        self.userID = userID
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
    
    init(firsttime lap1time:Double,secondtime lap2time:Double,thirdtime lap3time:Double,fourthtime lap4time:Double,fivetime lap5time:Double)
    {
        self.lap1time = lap1time
        self.lap2time = lap2time
        self.lap3time = lap3time
        self.lap4time = lap4time
        self.lap5time = lap5time
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
    init(firstdistance lap1distance:String)
    {
        self.lap1distance = lap1distance
    }
    init(time totaltime:String,_ sessionID:Int)
    {
        self.totaltime = totaltime
        self.sessionID = sessionID
    }
    init(firstdistance lap1distance:String,seconddistance lap2distance:String,thirddistance lap3distance:String,fourthdistance lap4distance:String,fifthdistance lap5distance:String,_ sessionID:Int)
    {
        self.lap1distance = lap1distance
        self.lap2distance = lap2distance
        self.lap3distance = lap3distance
        self.lap4distance = lap4distance
        self.lap5distance = lap5distance
        self.sessionID = sessionID
    }
    init(sessionid sessionID:Int,totalcalories totalcaloriesburnt:Double)
    {
        self.sessionID = sessionID
        self.totalcaloriesburnt = totalcaloriesburnt
    }
    init(sessionid sessionID:Int,totalspeed Totalspeed:Double)
    {
        self.sessionID = sessionID
        self.totalspeed = Totalspeed
    }
    init(sessionid sessionID:Int, currentdistance currentdistance:Double)
    {
       self.sessionID = sessionID
        self.currentdistance = currentdistance
    }
    init(sessionid sessionID:Int,sessioncomplete sessionComplete:Int)
    {
        self.sessionID = sessionID
        self.sessionComplete = sessionComplete
    }
    init(Month month:String, sessionid sessionID:Int , totaldistance totaldistance:Double, finishDate finishdate:String)
    {
        self.month = month
        self.sessionID = sessionID
        self.totaldistance = totaldistance
        self.finishdate = finishdate
    
    }
    init(Month month:String, allsessionid ALLsessionID:[Int] , alltotalDistance Alldistance:[Double],totalfinishDate totalfinishdate:[String],alltotaltime Alltotaltime:[String])
    {
        self.month = month
        self.AllSessionID = ALLsessionID
        self.AllDistance = Alldistance
        self.totalfinishdate = totalfinishdate
        self.allTotalTime = Alltotaltime
        self.expanded = false
    }
    init(Totalcalories totalcaloriesburnt:Double,TotalDistance totaldistance:Double,Totaltime totaltime: String,totalspeed TotalSpeed: Double)
    {
        self.totalcaloriesburnt = totalcaloriesburnt
        self.totaldistance = totaldistance
        self.totaltime = totaltime
        self.totalspeed = TotalSpeed
}
    init(longitude rangeoflongitude:String,latitude rangeoflatitude:String,_ sessionID:Int)
    {
        self.rangeoflongitude = rangeoflongitude
        self.rangeoflatitude = rangeoflatitude
        self.sessionID = sessionID
    }
    init(longitude rangeoflongitude:String,latitude rangeoflatitude:String)
    {
        self.rangeoflongitude = rangeoflongitude
        self.rangeoflatitude = rangeoflatitude
     
    }
}
