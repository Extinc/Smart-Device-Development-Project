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
    
    /*//Create Meal Table
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
    }*/
    
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
                "mealplantype text, " +
                "goals text, " +
                "duration text, " +
                "mealsperday int, " +
                "mealtiming text, " +
            "reminders text"
        )
    }
    
    //Retrieve
    static func loadPlanPreferences(username: String) -> [UserPlanPreferences]{
        let preferencesRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT mealplantype, goals, duration, mealsperday, mealtiming, reminders" +
                "FROM UserPlanPreferences" +
                "WHERE username = ?",
                parameters: [username]
        )
        
        var preferences : [UserPlanPreferences] = []
        if (preferencesRows.isEmpty == false){
            for row in preferencesRows
            {
                preferences.append(
                    UserPlanPreferences(row["username"] as! String,
                                        row["mealplantype"] as! String,
                                        row["goals"] as! String,
                                        row["duration"] as! String,
                                        row["mealsperday"] as! Int,
                                        row["mealtiming"] as! String,
                                        row["reminders"] as! String)
                )
            }
        }
        else {
            preferences.append(UserPlanPreferences("","","","",0,"",""))
        }
        
        return preferences
    }
    
    //Create/Update
    static func insertOrReplacePreferences(userPlanPreferences: UserPlanPreferences)
    {
        SQLiteDB.sharedInstance.execute(sql:
            "INSERT OR REPLACE INTO userPlanPreferences(username, mealplantype, goals, duration, mealsperday, mealtiming, reminders)" +
            "VALUE (?, ?, ?, ?, ?, ?, ?)",
                                        parameters: [
                                            userPlanPreferences.username,
                                            userPlanPreferences.mealPlanType,
                                            userPlanPreferences.goals,
                                            userPlanPreferences.duration,
                                            userPlanPreferences.mealsperday,
                                            userPlanPreferences.mealtiming,
                                            userPlanPreferences.reminders
                                            
            ]
        )
        
    }
    
    
    // MARK: - RECIPE
    
    //Create Recipe Table
    /*class func //getMealByCalories(onComplete: ((_ : [Meal]) -> Void)?){
        
    }*/
    
    /*static func createRecipeTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Recipe (" +
                "mealid int, " +
                "recipeid int primary key, " +
                "directions text, " +
                "ingredients text, " +
            "servingsize text"
        )
    }*/
}
