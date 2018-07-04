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
    
    // MARK: - MEAL
    
    
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
    static func loadMealPlans(username: String, date: String, onComplete: @escaping ([MealPlan]) -> Void)
    {
        //create empty list
        var mealPlanList : [MealPlan] = []
        let ref = FirebaseDatabase.Database.database().reference().child("mealPlan/")
        
        //observeSingleEventofType tells Firebase to load the full list of Meals
        //and execute the "with" closure once, when the download is complete
        ref.observeSingleEvent(of: .value,
                               with:
            { (snapshot) in
                // Executes the retrieval of data only when Firebase is complete
                // Meanwhile, before the download is complete, user can still interact with user interface
                for record in snapshot.children{
                    let r = record as! DataSnapshot
                    let Ddate = r.childSnapshot(forPath: "date").value as! String
                    if Ddate == date {
                        mealPlanList.append(MealPlan(
                            r.childSnapshot(forPath: "username") as! String,
                            r.childSnapshot(forPath: "date").value as! String,
                            r.childSnapshot(forPath: "mealID").value as! Int,
                            r.childSnapshot(forPath: "mealNo").value as! Int,
                            r.childSnapshot(forPath: "planID").value as! Int,
                            r.childSnapshot(forPath: "mealName").value as! String,
                            r.childSnapshot(forPath: "mealImage").value as! String,
                            r.childSnapshot(forPath: "calories").value as! String
                        ))
                    }
                }
                onComplete(mealPlanList)
        })
    }
    
    
    //Create/Update
    static func insertOrReplacePlan(mealplan: MealPlan) {
        let ref = FirebaseDatabase.Database.database().reference().child("mealPlan/\(mealplan.planID)")
        ref.setValue([
            "username" : mealplan.username,
            "date" : mealplan.date,
            "mealID" : mealplan.mealID,
            "mealNo" : mealplan.mealNo,
            "mealName" : mealplan.mealName,
            "mealImage" : mealplan.mealImage,
            "calories" : mealplan.calories
            
            ])
    }
    
    //Delete
    static func deletePlan (mealPlan: MealPlan){
        let ref = FirebaseDatabase.Database.database().reference().child("mealPlan/\(mealPlan.planID)")
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
                "reminders text, " +
                "FOREIGN KEY(username) REFERENCES User(username))"
        )
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
    
    static func createRecipeTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Recipe (" +
                "mealID int, " +
                "recipeID int primary key, " +
                "directions text, " +
                "ingredients text, " +
                "servingsize text, " +
                "FOREIGN KEY(mealID) REFERENCES Meal(mealID))"
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
