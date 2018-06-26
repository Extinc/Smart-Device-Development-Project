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
        DataManager.createTable(sql: "CREATE TABLE IF NOT EXIST " +
            "trainingschedule( " +
            " scheduleID int primary key autoincrement, " +
            " startdate text " +
            " numberoftimes double " +
            " progress int ," +
            " forfeit int default 0 ," +
            " complete int default 0 ," +
            " userID text, " +
            " foreign key(userID) REFERENCES User(userID)")
        
    }
}
