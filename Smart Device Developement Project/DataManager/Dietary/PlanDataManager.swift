//
//  PlanDataManager.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 21/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PlanDataManager: NSObject {
    
    // MARK: - MEAL PLAN
    
    //Create Meal Plan Table
    static func createMealPlanTable() {
        SQLiteDB.sharedInstance.execute(sql:
        "CREATE TABLE IF NOT EXISTS " +
        "MealPlan (" +
        "username text, " +
        "date text, " +
        "mealID int, " +
        "planID int primary key, " +
        "FOREIGN KEY(mealID) REFERENCES Meal(mealID))"
        )
    }

    //Retrieve ALL plans
    static func loadMealPlans(username: String, date: String) -> [MealPlan]
    {
        var mealPlanRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT username, date, mealID, mealNo, planID" +
            "FROM MealPlan" +
            "WHERE username = ?, date = ?",
                    parameters: [username, date]
        )
        
        let mName = "Chicken Rice"
        let mealImage = "Chicken Rice"
        let calories: Float = 0.0
        
        var mealplan : [MealPlan] = []
        if (mealPlanRows.isEmpty == false){
            for row in mealPlanRows
            {
                mealplan.append(MealPlan(row["username"] as! String,
                                             row["date"] as! String,
                                             row["mealID"] as! Int,
                                             row["mealNo"] as! Int,
                                             row["planID"] as! Int,
                                             mName,
                                             mealImage,
                                             calories))
            }
        }
        else {
            mealplan.append(MealPlan("","",0,0,0, "", "", 0))
        }
        
        return mealplan
    }
    
    
    //Create/Update
    static func insertOrReplaceMealPlan(mealPlan : MealPlan)
    {
        SQLiteDB.sharedInstance.execute(sql:
            "INSERT OR REPLACE INTO MealPlan(username, date, mealID, mealNo, planID)" +
            "VALUE (?, ?, ?, ?, ?)",
            parameters: [
                mealPlan.username,
                mealPlan.date,
                mealPlan.mealID,
                mealPlan.mealNo,
                mealPlan.planID
            ]
        )
        
    }
    
    
    //Delete
 
  
    
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
                "reminders text, " +
                "FOREIGN KEY(username) REFERENCES User(username))"
        )
    }
    
    
    
    //Create/Update
    static func insertOrReplacePreferences(userPlanPreferences: UserPlanPreferences)
    {
        SQLiteDB.sharedInstance.execute(sql:
            "INSERT OR REPLACE INTO userPlanPreferences(username, mealplantype, goals, duration, mealsperday, mealtiming, reminders)" +
            "VALUES(?, ?, ?, ?, ?, ?, ?)",
                                        parameters: [
                                            userPlanPreferences.username,
                                            userPlanPreferences.mealPlanType,
                                            userPlanPreferences.goals,
                                            userPlanPreferences.duration,
                                            userPlanPreferences.mealsperday,
                                            userPlanPreferences.mealtiming,
                                            userPlanPreferences.reminders]
        )
                
    }
    
    
    // MARK: - RECIPE
    
    //Create Recipe Table
    
    static func createRecipeTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Recipe (" +
                "mealID int, " +
                "recipeID int primary key, " +
                "directions text, " +
                "ingredients text, " +
                "servingsize text) "
        )
    }
    
    //Retrieve
    static func loadRecipe(mealid: Int) -> [Recipe]{
        let recipeRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT mealID, recipeID, directions, ingredients, servingSize" +
            "FROM UserPlanPreferences" +
            "WHERE username = ?",
            parameters: [mealid]
        )
        
        var recipe : [Recipe] = []
        if (recipeRows.isEmpty == false){
            for row in recipeRows
            {
                recipe.append(
                    Recipe(row["mealID"] as! Int,
                           row["recipeID"] as! Int,
                           row["directions"] as! String,
                           row["ingredients"] as! String,
                           row["servingSize"] as! String)
                )
            }
        }
        else {
            recipe.append(Recipe(0,0,"","",""))
        }
        
        return recipe
    }

}
