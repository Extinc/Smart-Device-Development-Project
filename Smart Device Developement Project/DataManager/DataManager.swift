//
//  DataManager.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DataManager: NSObject {
    static func createTable(sql: String){
        SQLiteDB.sharedInstance.execute(sql: sql)
    }
    
    // for login
    static func createUserInfoTable(){
        DataManager.createTable(sql:
                "CREATE TABLE IF NOT EXISTS " +
                "User( " +
                "   userID text primary key, " +
                "   email text )")
        
    }

    
    static func insertUserInfo(uid: String, email: String){
        insertOrReplace(tableName: "User", tableCols: " userID, email ", valuesql: "?,?", params: [uid,email])
    }
    
    static func insertOrReplace(tableName: String, tableCols: String,valuesql: String, params: [Any]?){
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO \(tableName) (\(tableCols)) VALUES (\(valuesql))",
            parameters: params!)
    }
    
    static func checkUserExist(params: [Any]?) -> Bool{
        var exist = false
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT userID, email " +
            "FROM User WHERE userID = ? AND email = ? ", parameters: params!)
        
        if categoryRows.count >= 1 {
            exist = true
        } else {
            exist = false
        }
        return exist
    }
    
    static func insertHWIntoDB(uid: String, height: String, weight: String){
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Profile").child(uid).child("height").setValue(height)
        ref.child("Profile").child(uid).child("weight").setValue(weight)
    }
}
