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
            "currentdistance INTEGER ," +
            "totaldistnace INTEGER ," +
            "finishdate TEXT ," +
            "lap1speed TEXT ," +
            "lap2speed TEXT ," +
            "lap3speed TEXT ," +
            "lap4speed TEXT ," +
            "lap5speed TEXT ," +
            "lap1estimateddistance TEXT ," +
            "lap2estimateddistance TEXT ," +
            "lap3estimateddistance TEXT ," +
            "lap4estimateddistance TEXT ," +
            "lap5estimateddistance TEXT ," +
            "lap1distance TEXT ," +
            "lap2distance TEXT ," +
            "lap3distance TEXT ," +
            "lap4distance TEXT ," +
            "lap5distance TEXT ," +
            "totalcaloriesburnt TEXT ," +
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
    
    static func forfeitSchedule(_ user:String) -> Bool{
        SQLiteDB.sharedInstance.query(sql: "Update trainingschedule SET forfeit = 1 where complete = 0 AND forfeit = 0")
        return true
    }
    
    static func loadScheduleInformation(_ user:String) -> Schedule{
        let currentSchedulerow = SQLiteDB.sharedInstance.query(sql: "Select scheduleID,startdate,day,distance,numberoftimes, progress,eventstoresaved, eventsaved, userID from trainingschedule where forfeit = 0 AND complete = 0 AND userID= \"\(user)\"" )
        
        var currentschedule = Schedule("","","","","","","","")
        for row in currentSchedulerow
        {
          currentschedule = Schedule(row["startdate"] as! String,row["day"] as! String,row["distance"] as! String,row["numberoftimes"] as! String,row["progress"] as! String,row["userID"] as! String,row["eventstoresaved"] as! String, row["eventsaved"] as! String)
        }
        
       return currentschedule
    }
    
    
   
    
    
}
