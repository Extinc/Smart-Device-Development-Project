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
            "trainingdistance TEXT ," +
            "numberoftimes INTEGER ," +
            "progress INTEGER ," +
            "day TEXT ," +
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
    
    static func loadSchedule(_ user:String) -> Schedule{
        let schedulerow =
        SQLiteDB.sharedInstance.query(sql: "SELECT scheduleID, startdate, " +
            "trainingdistance, numberoftimes, progress, forfeit, complete, userID FROM schedule WHERE forfeit = 0 AND complete = 0 AND userID = "+ user +"")
        
       let selectedSchedules = Schedule( ["scheduleID"] as! Int,["startdate"] as! String,["trainingdistance"] as! String,["numberoftimes"] as! Int,["progress"] as! String,["forfeit"] as! Int,["complete"] as! Int,["userID"] as! String)
       
    
        return selectedSchedules
    }
    static func insertOrReplaceSchedule(schedule: Schedule)
    {
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO Schedule ( startdate, trainingdistance, numberoftimes, progress, userID) " +
        "Values (? , ? , ? , ? , ?)", parameters: [schedule.startDate , schedule.trainingdistance, schedule.numberoftimes, schedule.progress, schedule.userID]
        )
    }
    
    static func checkUserExist(_ user:String) -> Bool{
        var exist = false
        let ScheduleRows = SQLiteDB.sharedInstance.query(sql:
            "Select count(scheduleID) FROM schedule where forfeit = 0 AND complete = 0 AND userID = "+ user +"")
        
        if ScheduleRows.count >= 1 {
            exist = true
        } else {
            exist = false
        }
        return exist
    }
    
    
}
