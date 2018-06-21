//
//  PlanDataManager.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 21/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class PlanDataManager: NSObject {
    
    // MARK: - MEAL
    
    //Create Meal Table
    static func createMealTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Meal (" +
                "mealid int primary key, " +
                "name text, " +
                "calories real, " +
                "carbohydrates real, " +
                "protein real, " +
                "fat real, " +
            "sodium real "
        )
    }
    
    // MARK: - MEAL PLAN
    
    //Create Meal Plan Table
    static func createMealPlanTable() {
        SQLiteDB.sharedInstance.execute(sql:
        "CREATE TABLE IF NOT EXISTS " +
        "MealPlan (" +
        "username text, " +
        "date text, " +
        "mealID int, " +
        "planID int primary key"
        )
    }

    //Retrieve
    static func loadPlans(username: String) -> [MealPlan]{
        let planRows = SQLiteDB.sharedInstance.query(sql:
        "SELECT date, mealID, mealNo, planID" +
        "FROM MealPlan" +
        "WHERE username = ?",
        parameters: [username]
        )
        
        var plan : [MealPlan] = []
        for row in planRows
        {
            plan.append(
                MealPlan(username: row["username"] as! String,
                         date: row["date"] as! String,
                         mealID: row["mealID"] as! Int,
                         mealNo: row["mealNo"] as! Int,
                         planID:row["planID"] as! Int)
            )
        }
        return plan
    }
    
    //Create/Update
    static func insertOrReplacePlan(mealplan: MealPlan)
    {
        SQLiteDB.sharedInstance.execute(sql:
            "INSERT OR REPLACE INTO MealPlan(username, date, mealID, mealNo, planID)" +
            "VALUE (?, ?, ?, ?, ?)",
            parameters: [
                mealplan.username,
                mealplan.date,
                mealplan.mealID,
                mealplan.mealNo,
                mealplan.planID
            ]
        )
        
    }
    
    //Delete
    static func deletePlan (mealPlan: MealPlan){
        SQLiteDB.sharedInstance.execute(sql:
        "DELETE FROM MealPlan WHERE planID = ?",
            parameters: [mealPlan.planID]
            
        )
    }
    
  
    
    // MARK: - USER PLAN PREFERENCES
    
    //Create User Plan Preferences Table
    static func createUPTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "UserPlanPreferences (" +
                "username text primary key, " +
                "mealplan text, " +
                "goals text, " +
                "duration text, " +
                "mealsperday int, " +
                "mealtiming int, " +
            "reminders text"
        )
    }
    
    // MARK: - RECIPE
    
    //Create Recipe Table
    static func createRecipeTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Recipe (" +
                "mealid int, " +
                "recipeid int primary key, " +
                "directions text, " +
                "ingredients text, " +
            "servingsize text"
        )
    }
}
