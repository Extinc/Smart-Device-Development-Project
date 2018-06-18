//
//  DataManager.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static func createTable(sql: String){
        SQLiteDB.sharedInstance.execute(sql: sql)
    }
}
