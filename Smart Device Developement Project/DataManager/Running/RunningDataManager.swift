//
//  RunningDataManager.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RunningDataManager: NSObject {
    static func createScheduleTable(){
        DataManager.createTable(sql: "CREATE TABLE IF NOT EXISTS " +
            "trainingschedule( " +
            "scheduleID INTEGER primary key autoincrement, " +
            "startdate TEXT ," +
            "distance TEXT ," +
            "numberoftimes TEXT ," +
            "progress TEXT ," +
            "day TEXT ," +
            "eventstoresaved TEXT ," +
            "eventsaved TEXT ," +
            "forfeit INTEGER default 0 ," +
            "complete INTEGER default 0 ," +
            "userID TEXT, " +
            "foreign key(userID) REFERENCES User(userID))")
    }
    static func createSessionTable(){
        DataManager.createTable(sql: "CREATE TABLE IF NOT EXISTS " +
            "Session( " +
            "sessionID INTEGER primary key autoincrement, " +
            "currentdistance Double DEFAULT 0," +
            "totaldistance Double ," +
            "totaltime String ," +
            "finishdate TEXT DEFAULT '0'," +
            "lap1speed TEXT DEFAULT '0'," +
            "lap2speed TEXT DEFAULT '0'," +
            "lap3speed TEXT DEFAULT '0'," +
            "lap4speed TEXT DEFAULT '0'," +
            "lap1time Double DEFAULT 0," +
            "lap2time Double DEFAULT 0," +
            "lap3time Double DEFAULT 0," +
            "lap4time Double DEFAULT 0," +
            "lap5time Double DEFAULT 0," +
            "lap1estimateddistance TEXT DEFAULT '0'," +
            "lap2estimateddistance TEXT DEFAULT '0'," +
            "lap3estimateddistance TEXT DEFAULT '0'," +
            "lap4estimateddistance TEXT DEFAULT '0'," +
            "lap5estimateddistance TEXT DEFAULT '0'," +
            "lap1distance TEXT DEFAULT '0'," +
            "lap2distance TEXT DEFAULT '0'," +
            "lap3distance TEXT DEFAULT '0'," +
            "lap4distance TEXT DEFAULT '0'," +
            "lap5distance TEXT DEFAULT '0'," +
            "totalcaloriesburnt DOUBLE DEFAULT '0'," +
            "sessionComplete INTEGER default 0 ," +
            "scheduleID INTEGER, " +
            "foreign key(scheduleID) REFERENCES trainingschedule(scheduleID))")
        
    }
    
    //static func loadSchedule(_ user:String) -> Schedule{
     //   let schedulerow =
     //   SQLiteDB.sharedInstance.query(sql: "SELECT scheduleID, startdate, " +
     //       "trainingdistance, numberoftimes, progress, forfeit, complete, userID FROM schedule WHERE forfeit = 0 AND complete = 0 AND userID = \(user)")
        
     //  let selectedSchedules = Schedule(["scheduleID"] as! Int, ["startdate"] as! String, ["day"] as! String, ["distance"] as! String, ["numberoftimes"] as! Int, ["progress"] as! String, ["forfeit"] as! Int, ["complete"] as! Int, ["userID"] as! String)
       
    
    //    return selectedSchedules
  //  }
    static func insertOrReplaceSchedule(schedule: Schedule)
    {
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO trainingschedule ( startdate, day, distance, numberoftimes, progress, userID, eventstoresaved, eventsaved) " +
        "Values (? , ? , ? , ? , ?, ?, ?, ?)", parameters: [schedule.startDate , schedule.day, schedule.trainingdistance, schedule.numberoftimes, schedule.progress, schedule.userID, schedule.eventstoresaved, schedule.eventsaved]
        )
    }
    
    static func checkUserScheduleExist(_ user:String) -> Bool{
        var exist = false
        let ScheduleRows = SQLiteDB.sharedInstance.query(sql:
            "Select scheduleID FROM trainingschedule where forfeit = 0 AND complete = 0 AND userID =  \"\(user)\"" )
        
        if ScheduleRows.count >= 1 {
            exist = true                // Means there is an existing schedule
        } else {
            exist = false               // No exi/Users/angbryan/Documents/Smart-Device-Development-Project/Smart Device Developement Projectsting schedule
        }
        return exist
    }
    static func checkUserScheduleFinished(_ scheduleId:Int) -> Bool{
        var exist = false
        let ScheduleRows = SQLiteDB.sharedInstance.query(sql:
            "Select scheduleID FROM trainingschedule where forfeit = 0 AND complete = 1 AND scheduleId =  \(scheduleId)")
        
        if ScheduleRows.count >= 1 {
            exist = true                // Means there is an existing schedule
        } else {
            exist = false               // No exi/Users/angbryan/Documents/Smart-Device-Development-Project/Smart Device Developement Projectsting schedule
        }
        return exist
    }
    
    static func forfeitSchedule(_ user:String) -> Bool{
        SQLiteDB.sharedInstance.query(sql: "Update trainingschedule SET forfeit = 1 where complete = 0 AND forfeit = 0")
        return true
    }
    
    static func loadScheduleInformation(_ user:String) -> Schedule{
        let currentSchedulerow = SQLiteDB.sharedInstance.query(sql: "Select scheduleID,startdate,day,distance,numberoftimes, progress,eventstoresaved, eventsaved, userID from trainingschedule where forfeit = 0 AND complete = 0 AND userID= \"\(user)\"" )
        
        var currentschedule = Schedule(0,"","","","","","","","")
        for row in currentSchedulerow
        {
          currentschedule = Schedule(row["scheduleID"] as! Int,row["startdate"] as! String,row["day"] as! String,row["distance"] as! String,row["numberoftimes"] as! String,row["progress"] as! String,row["userID"] as! String,row["eventstoresaved"] as! String, row["eventsaved"] as! String)
        }
        
       return currentschedule
    }
    static func selectlastSessionTableId() -> Int{
        let currentid = SQLiteDB.sharedInstance.query(sql: "Select Max(SessionID) from Session")
        var id : Int = 0
        for row in currentid{
         id = row["Max(SessionID)"] as! Int
        }
        return id
    }
    static func selectlastScheduleTableId() -> Int{
        let currentid = SQLiteDB.sharedInstance.query(sql: "Select Max(scheduleID) from trainingschedule")
        var id : Int = 0
        for row in currentid{
            if(row["Max(scheduleID"] == nil)
            {
                id = 0
            }
            else
            {
            id = row["Max(scheduleID)"] as! Int
            }
        }
        return id
    }
    
    static func insertOrReplaceSession(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO Session(scheduleID,currentdistance,totaldistance,finishdate,totaltime,totalcaloriesburnt) " + "Values (?,?,?,?,?,?)", parameters: [session.scheduleID,session.currentdistance, session.totaldistance, session.finishdate,session.totaltime, session.totalcaloriesburnt	])
    }
    static func UpdateSessionSpeed(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1speed = ?, lap2speed = ?, lap3speed = ?, lap4speed = ?, lap5speed = ? Where sessionID = ?", parameters: [session.lap1speed, session.lap2speed, session.lap3speed, session.lap4speed, session.lap5speed,session.sessionID])
    }
    static func UpdateSessionEstimatedDistance(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1estimateddistance = ?, lap2estimateddistance = ?, lap3estimateddistance = ?, lap4estimateddistance = ?, lap5estimateddistance = ? Where sessionID = ?", parameters: [session.lap1estimateddistance, session.lap2estimateddistance, session.lap3estimateddistance, session.lap4estimateddistance, session.lap5estimateddistance])
    }
    static func UpdateSessionDistance(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1distance = ?, lap2distance = ?, lap3distance = ?, lap4distance = ?, lap5distance = ? Where sessionID = ?", parameters: [session.lap1distance, session.lap2distance, session.lap3distance, session.lap4distance, session.lap5distance, session.scheduleID])
    }
    static func UpdateSessiontime(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1time = ?, lap2time = ?, lap3time = ?, lap4time = ?, lap5time = ? Where sessionID = ?", parameters: [session.lap1time, session.lap2time, session.lap3time, session.lap4time, session.lap5time, session.scheduleID])
    }
    static func UpdateSession(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ?,totaldistance = ?,finishdate = ?,totalcaloriesburnt = ? Where sessionID = ? ", parameters: [session.currentdistance, session.totaldistance, session.finishdate, session.totalcaloriesburnt, session.sessionID])
    }
   
    static func UpdateTotalTime(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET totaltime = ? Where sessionID = ? ", parameters: [session.totaltime,session.scheduleID])
    }
    static func UpdateProgress(Schedule: Schedule)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update trainingschedule SET progress = ? Where scheduleID = ? ", parameters: [Schedule.progress,Schedule.scheduleId])
    }
    static func UpdateComplete(_ scheduleid:Int)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update trainingschedule SET complete = 1 Where scheduleID = ? ", parameters: [scheduleid])
    }
    static func UpdateTotalCalories(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET totalcaloriesburnt = ? Where sessionID = ? ", parameters: [session.totalcaloriesburnt,session.scheduleID])
    }
    static func UpdateCurrentDistance(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ? Where sessionID = ? ", parameters: [session.currentdistance,session.scheduleID])
    }
    static func UpdateCurrent(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ? Where sessionID = ? ", parameters: [session.currentdistance,session.scheduleID])
    }
    static func UpdateCurrentComplete(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET sessionComplete = ? Where sessionID = ? ", parameters: [session.sessionComplete,session.scheduleID])
    }
    
    
}
    
    
   
    
    
