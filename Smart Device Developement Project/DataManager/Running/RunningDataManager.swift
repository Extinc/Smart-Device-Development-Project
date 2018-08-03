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
            "month String ," +
            "finishdate TEXT DEFAULT '0'," +
            "lap1speed TEXT DEFAULT '0'," +
            "lap2speed TEXT DEFAULT '0'," +
            "lap3speed TEXT DEFAULT '0'," +
            "lap4speed TEXT DEFAULT '0'," +
            "lap5speed TEXT DEFAULT '0'," +
            "lap1time Double DEFAULT 0," +
            "lap2time Double DEFAULT 0," +
            "lap3time Double DEFAULT 0," +
            "lap4time Double DEFAULT 0," +
            "lap5time Double DEFAULT 0," +
            "totalspeed Double DEFAULT 0," +
            "lap1distance TEXT DEFAULT '0'," +
            "lap2distance TEXT DEFAULT '0'," +
            "lap3distance TEXT DEFAULT '0'," +
            "lap4distance TEXT DEFAULT '0'," +
            "lap5distance TEXT DEFAULT '0'," +
            "Runlogitude TEXT DEFAULT '0'," +
            "Runlatitude TEXT DEFAULT '0'," +
            "userID TEXT," +
            "totalcaloriesburnt DOUBLE DEFAULT '0'," +
            "sessionComplete INTEGER default 0," +
            "scheduleID INTEGER, " +
            "foreign key(scheduleID) REFERENCES trainingschedule(scheduleID))")
        
    }
 
    static func insertOrReplaceSchedule(schedule: Schedule)
    {
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO trainingschedule ( startdate, day, distance, numberoftimes, progress, userID, eventstoresaved, eventsaved) " +
        "Values (? , ? , ? , ? , ?, ?, ?, ?)", parameters: [schedule.startDate , schedule.day, schedule.trainingdistance, schedule.numberoftimes, schedule.progress, schedule.userID, schedule.eventstoresaved, schedule.eventsaved]
        )
    }
    
    static func checkUserScheduleComplete(_ user:String) -> Int{
        var count = 0
        let ScheduleRows = SQLiteDB.sharedInstance.query(sql:
            "Select count(scheduleID) FROM trainingschedule where forfeit = 0 AND complete = 1 AND userID =  \"\(user)\"" )
        
        if ScheduleRows.count >= 1 {
            for row in ScheduleRows{
                count = row["count(scheduleID)"] as! Int
            }
            } else
        {
           count = 0               
        }
        return count
    }
    static func checkUserScheduleforfeit(_ user:String) -> Int{
        var count = 0
        let ScheduleRows = SQLiteDB.sharedInstance.query(sql:
            "Select count(scheduleID) FROM trainingschedule where forfeit = 1 AND complete = 0 AND userID =  \"\(user)\"" )
        
        if ScheduleRows.count >= 1 {
            for row in ScheduleRows{
                count = row["count(scheduleID)"] as! Int
            }
        } else
        {
            count = 0
        }
        return count
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
    static func deleteSession(_ sessionID:Int) -> Bool{
        SQLiteDB.sharedInstance.query(sql: "Delete from Session where sessionID = \(sessionID)")
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
    static func loadPreviousSession(_ sessionID:Int) -> Session{
        let previousScheduleTime = SQLiteDB.sharedInstance.query(sql: "Select lap1time,lap2time,lap3time,lap4time,lap5time from Session where sessionID = \(sessionID)")
        var previousScheduleLapTime = Session(firsttime : 0, secondtime: 0, thirdtime: 0, fourthtime: 0, fivetime: 0)
        for row in previousScheduleTime
        {
            previousScheduleLapTime = Session(firsttime: row["lap1time"] as! Double,secondtime: row["lap2time"] as! Double,thirdtime: row["lap3time"] as! Double,fourthtime: row["lap4time"] as! Double,fivetime: row["lap5time"] as! Double)
        }
        
        return previousScheduleLapTime
        
    }
    
    static func loadSessionSpeed(_ sessionID:Int) -> Session{
        let ScheduleSpeed = SQLiteDB.sharedInstance.query(sql: "Select lap1speed,lap2speed,lap3speed,lap4speed,lap5speed from Session where sessionID = \(sessionID)")
        var previousScheduleSpeed = Session(firstspeed : "", secondspeed: "", thirdspeed: "", fourthspeed: "", fifthspeed: "")
        for row in ScheduleSpeed
        {
            previousScheduleSpeed = Session(firstspeed: row["lap1speed"] as! String,secondspeed: row["lap2speed"] as! String,thirdspeed: row["lap3speed"] as! String,fourthspeed: row["lap4speed"] as! String,fifthspeed: row["lap5speed"] as! String)
        }
        
        return previousScheduleSpeed
        
    }
    static func loadSessionByID(_ sessionID:Int) -> Session{
        let selectSessionInfo = SQLiteDB.sharedInstance.query(sql: "Select totalcaloriesburnt,totaldistance,totaltime,totalspeed from Session where sessionID = \(sessionID)")
        
        var selectedinfo = Session(Totalcalories: 0, TotalDistance: 0, Totaltime: "",totalspeed: 0.0)
        
        for row in selectSessionInfo
        {
            selectedinfo = Session(Totalcalories: row["totalcaloriesburnt"] as! Double,TotalDistance:row["totaldistance"] as! Double,Totaltime:row["totaltime"] as! String, totalspeed:row["totalspeed"] as! Double)
        }
        
        return selectedinfo
    
    }
    static func loadSessionLapDistancebyID(_ sessionID:Int) -> String{
        let selectSessionInfo = SQLiteDB.sharedInstance.query(sql: "Select lap1distance from Session where sessionID = \(sessionID)")
        
        var selecteddistance = ""
        
        for row in selectSessionInfo
        {
            selecteddistance = row["lap1distance"] as! String
        }
        
        return selecteddistance
        
    }
    static func loadSessionlocationByID(_ sessionID:Int) -> Session{
        let selectSessionInfo = SQLiteDB.sharedInstance.query(sql: "Select Runlogitude,Runlatitude from Session where sessionID = \(sessionID)")
        
        var selectedinfo = Session(longitude : "" , latitude : "")
        
        for row in selectSessionInfo
        {
            selectedinfo = Session(longitude: row["Runlogitude"] as! String, latitude:row["Runlatitude"] as! String)
        }
        
        print("range of longitude\(selectedinfo.rangeoflongitude) range of latitude\(selectedinfo.rangeoflatitude)")
        
        return selectedinfo
        
    }
    
    static func loadallsession(_ userID:String) -> [Session]{
        let allsession = SQLiteDB.sharedInstance.query(sql: "Select sessionID,totaldistance,finishdate,month,totaltime,totalcaloriesburnt from Session Where sessionComplete = 1 AND userID = \"\(userID)\"" )
        var jancall: Int = 0
        var febcall: Int = 0
        var marcall: Int = 0
        var aprcall: Int = 0
        var maycall: Int = 0
        var juncall: Int = 0
        var julcall: Int = 0
        var augcall: Int = 0
        var sepcall: Int = 0
        var octcall: Int = 0
        var novcall: Int = 0
        var deccall: Int = 0
        
        var call: Int = 1
        //January
         var jandate : [String] = []
        var  janid: [Int] = []
        var  jandistance: [Double] = []
        var  jantime: [String] = []
        var  jancalories: [Double] = []
        //February
        var febdate : [String] = []
        var febid: [Int] = []
        var febdistance: [Double] = []
        var febtime: [String] = []
        var  febcalories: [Double] = []
        //March
        var mardate : [String] = []
        var marid: [Int] = []
        var mardistance: [Double] = []
        var martime: [String] = []
        var marcalories: [Double] = []
        //April
        var aprdate : [String] = []
        var aprid: [Int] = []
        var aprdistance: [Double] = []
        var aprtime: [String] = []
        var aprcalories: [Double] = []
        //May
        var maydate : [String] = []
        var mayid: [Int] = []
        var maydistance: [Double] = []
        var maytime: [String] = []
        var maycalories: [Double] = []
        //June
        var jundate : [String] = []
        var junid: [Int] = []
        var jundistance: [Double] = []
        var juntime: [String] = []
        var juncalories: [Double] = []
        //July
        var juldate : [String] = []
        var julid: [Int] = []
        var juldistance: [Double] = []
        var jultime: [String] = []
        var julcalories: [Double] = []
        //Aug
        var augdate : [String] = []
        var augid: [Int] = []
        var augdistance: [Double] = []
        var augtime: [String] = []
        var augcalories: [Double] = []
        //Sep
        var sepdate : [String] = []
        var sepid: [Int] = []
        var sepdistance: [Double] = []
        var septime: [String] = []
        var sepcalories: [Double] = []
        //Oct
        var octdate : [String] = []
        var octid: [Int] = []
        var octdistance: [Double] = []
        var octtime: [String] = []
        var octcalories: [Double] = []
        //Nov
        var novdate : [String] = []
        var novid: [Int] = []
        var novdistance: [Double] = []
        var novtime: [String] = []
        var novcalories: [Double] = []
        //Dec
        var decdate : [String] = []
        var decid: [Int] = []
        var decdistance: [Double] = []
        var dectime: [String] = []
        var deccalories: [Double] = []
        //All session
        var allSession : [Session] = []
        var eachsession = Session(Month :"", sessionid :0 , totaldistance :0.0, finishDate:"",totalCalories: 0)
        for row in allsession
        {
            if(row["month"] as! String == "January")
            {
                jancall = 1
                jandate.append(row["finishdate"] as! String)
                janid.append(row["sessionID"] as! Int)
                jandistance.append(row["totaldistance"] as! Double)
                jantime.append(row["totaltime"] as! String)
                jancalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "February")
            {
                febcall = 1
                febdate.append(row["finishdate"] as! String)
                febid.append(row["sessionID"] as! Int)
                febdistance.append(row["totaldistance"] as! Double)
                febtime.append(row["totaltime"] as! String)
                febcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "March")
            {
                marcall = 1
                mardate.append(row["finishdate"] as! String)
                marid.append(row["sessionID"] as! Int)
                mardistance.append(row["totaldistance"] as! Double)
                martime.append(row["totaltime"] as! String)
                marcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "April")
            {
                aprcall = 1
                aprdate.append(row["finishdate"] as! String)
                aprid.append(row["sessionID"] as! Int)
                aprdistance.append(row["totaldistance"] as! Double)
                aprtime.append(row["totaltime"] as! String)
                aprcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "May")
            {
                maycall = 1
                maydate.append(row["finishdate"] as! String)
                mayid.append(row["sessionID"] as! Int)
                maydistance.append(row["totaldistance"] as! Double)
                maytime.append(row["totaltime"] as! String)
                maycalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "June")
            {
                juncall = 1
                jundate.append(row["finishdate"] as! String)
                junid.append(row["sessionID"] as! Int)
                jundistance.append(row["totaldistance"] as! Double)
                juntime.append(row["totaltime"] as! String)
                juncalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "July")
            {
                julcall = 1
                juldate.append(row["finishdate"] as! String)
                julid.append(row["sessionID"] as! Int)
                juldistance.append(row["totaldistance"] as! Double)
                jultime.append(row["totaltime"] as! String)
                julcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "August")
            {
                augcall = 1
                augdate.append(row["finishdate"] as! String)
                augid.append(row["sessionID"] as! Int)
                augdistance.append(row["totaldistance"] as! Double)
                augtime.append(row["totaltime"] as! String)
                augcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "September")
            {
                sepcall = 1
                sepdate.append(row["finishdate"] as! String)
                sepid.append(row["sessionID"] as! Int)
                sepdistance.append(row["totaldistance"] as! Double)
                septime.append(row["totaltime"] as! String)
                sepcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "October")
            {
                octcall = 1
                octdate.append(row["finishdate"] as! String)
                octid.append(row["sessionID"] as! Int)
                octdistance.append(row["totaldistance"] as! Double)
                octtime.append(row["totaltime"] as! String)
                octcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "November")
            {
                novcall = 1
                novdate.append(row["finishdate"] as! String)
                novid.append(row["sessionID"] as! Int)
                novdistance.append(row["totaldistance"] as! Double)
                novtime.append(row["totaltime"] as! String)
                novcalories.append(row["totalcaloriesburnt"] as! Double)
            }
            if(row["month"] as! String == "December")
            {
                deccall = 1
                decdate.append(row["finishdate"] as! String)
                decid.append(row["sessionID"] as! Int)
                decdistance.append(row["totaldistance"] as! Double)
                dectime.append(row["totaltime"] as! String)
                deccalories.append(row["totalcaloriesburnt"] as! Double)
            }
            
        }
       if (jancall == 1)
       {
        eachsession = Session(Month : "January" ,allsessionid : janid ,alltotalDistance :jandistance ,totalfinishDate: jandate,alltotaltime :jantime, allCalories : jancalories)
         allSession.append(eachsession)
        }
        if (febcall == 1)
        {
            eachsession = Session(Month : "February" ,allsessionid : febid ,alltotalDistance :febdistance ,totalfinishDate: febdate,alltotaltime :febtime, allCalories : febcalories)
            allSession.append(eachsession)
        }
        if (marcall == 1)
        {
            eachsession = Session(Month : "March" ,allsessionid : marid ,alltotalDistance :mardistance ,totalfinishDate: mardate,alltotaltime :martime, allCalories : marcalories)
            allSession.append(eachsession)
        }
        if (aprcall == 1)
        {
            eachsession = Session(Month : "April" ,allsessionid : aprid ,alltotalDistance :aprdistance ,totalfinishDate: aprdate,alltotaltime :aprtime, allCalories : aprcalories)
            allSession.append(eachsession)
        }
        if (maycall == 1)
        {
            eachsession = Session(Month : "May" ,allsessionid : mayid ,alltotalDistance :maydistance ,totalfinishDate: maydate,alltotaltime :maytime, allCalories : maycalories)
            allSession.append(eachsession)
        }
        if (juncall == 1)
        {
            eachsession = Session(Month : "June" ,allsessionid : junid ,alltotalDistance :jundistance ,totalfinishDate: jundate,alltotaltime :juntime, allCalories : juncalories)
            allSession.append(eachsession)
        }
        if (julcall == 1)
        {
            eachsession = Session(Month : "July" ,allsessionid : julid ,alltotalDistance :juldistance ,totalfinishDate: juldate,alltotaltime :jultime, allCalories : julcalories)
            allSession.append(eachsession)
        }
        if (augcall == 1)
        {
            eachsession = Session(Month : "August" ,allsessionid : augid ,alltotalDistance :augdistance ,totalfinishDate: augdate,alltotaltime :augtime, allCalories : augcalories)
            allSession.append(eachsession)
        }
        if (sepcall == 1)
        {
            eachsession = Session(Month : "September" ,allsessionid : sepid ,alltotalDistance :sepdistance ,totalfinishDate: sepdate,alltotaltime :septime, allCalories : sepcalories)
            allSession.append(eachsession)
        }
        if (octcall == 1)
        {
            eachsession = Session(Month : "November" ,allsessionid : octid ,alltotalDistance :octdistance ,totalfinishDate: octdate,alltotaltime :octtime, allCalories : octcalories)
            allSession.append(eachsession)
        }
        if (novcall == 1)
        {
            allSession.append(eachsession)
            eachsession = Session(Month : "July" ,allsessionid : novid ,alltotalDistance :novdistance ,totalfinishDate: novdate,alltotaltime :novtime, allCalories : novcalories)
        }
        if (deccall == 1)
        {
            eachsession = Session(Month : "December" ,allsessionid : decid ,alltotalDistance :decdistance ,totalfinishDate: decdate,alltotaltime :dectime, allCalories : deccalories)
            allSession.append(eachsession)
        }
        
       
            return allSession
        
    }
    static func selectlastSessionTableId() -> Int{
        let currentid = SQLiteDB.sharedInstance.query(sql: "Select Max(SessionID) from Session")
        var id : Int = 0
        for row in currentid{
            if(row["Max(SessionID)"] == nil)
            {
                id = 0
            }
            else
            {
                id = row["Max(SessionID)"] as! Int
            }
        }
        return id
    }
    static func selectlastScheduleTableId(_ userID:String) -> Int{
        let currentid = SQLiteDB.sharedInstance.query(sql: "Select Max(scheduleID) from trainingschedule where userID =  \"\(userID)\"")
        var id : Int = 0
        for row in currentid{
            if(row["Max(scheduleID)"] == nil)
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
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO Session(scheduleID,currentdistance,totaldistance,finishdate,totaltime,totalcaloriesburnt,month,userID) " + "Values (?,?,?,?,?,?,?,?)", parameters: [session.scheduleID,session.currentdistance, session.totaldistance, session.finishdate,session.totaltime, session.totalcaloriesburnt, session.month,session.userID])
    }
    static func UpdateSessionSpeed(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1speed = ?, lap2speed = ?, lap3speed = ?, lap4speed = ?, lap5speed = ? Where sessionID = ?", parameters: [session.lap1speed, session.lap2speed, session.lap3speed, session.lap4speed, session.lap5speed,session.sessionID])
    }
    static func UpdateSessionDistance(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1distance = ?, lap2distance = ?, lap3distance = ?, lap4distance = ?, lap5distance = ? Where sessionID = ?", parameters: [session.lap1distance, session.lap2distance, session.lap3distance, session.lap4distance, session.lap5distance, session.sessionID])
    }
    static func UpdateSessiontime(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET lap1time = ?, lap2time = ?, lap3time = ?, lap4time = ?, lap5time = ? Where sessionID = ?", parameters: [session.lap1time, session.lap2time, session.lap3time, session.lap4time, session.lap5time, session.sessionID])
    }
    static func UpdateSession(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ?,totaldistance = ?,finishdate = ?,totalcaloriesburnt = ? Where sessionID = ? ", parameters: [session.currentdistance, session.totaldistance, session.finishdate, session.totalcaloriesburnt, session.sessionID])
    }
   
    static func UpdateTotalTime(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET totaltime = ? Where sessionID = ? ", parameters: [session.totaltime,session.sessionID])
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
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET totalcaloriesburnt = ? Where sessionID = ? ", parameters: [session.totalcaloriesburnt,session.sessionID])
    }
    static func UpdateCurrentDistance(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ? Where sessionID = ? ", parameters: [session.currentdistance,session.sessionID])
    }
    static func UpdateCurrent(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET currentdistance = ? Where sessionID = ? ", parameters: [session.currentdistance,session.sessionID])
    }
    static func UpdateCurrentComplete(session: Session)
    {
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET sessionComplete = ? Where sessionID = ? ", parameters: [session.sessionComplete,session.sessionID])
    }
    static func UpdateTotalSpeed(session: Session)
    {

        SQLiteDB.sharedInstance.execute(sql: "Update Session SET totalspeed = ? Where sessionID = ? ", parameters: [session.totalspeed,session.sessionID])
    }
    static func UpdateLocation(session: Session)
    {
        
        SQLiteDB.sharedInstance.execute(sql: "Update Session SET Runlogitude = ? , Runlatitude = ? Where sessionID = ? ", parameters: [session.rangeoflongitude,session.rangeoflatitude,session.sessionID])
    }
    
    
}

    
   
    
    

