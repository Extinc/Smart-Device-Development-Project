//
//  ExerciseCreateDataManager.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 26/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ExerciseCreateDataManager: NSObject {
    // *************************************************************************************
    //  Creating Table for Database
    // *************************************************************************************
    
    static func createWorkoutTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Workout( " +
                "   workoutID int primary key, " +
                "   name text, " +
                "   equipment int, " +
                "   description text, " +
                "   category int, " +
                "   type text," +
                "   videolink text, " +
                "   imgurls text, " +
                "   muscleimgurls text, " +
                "   FOREIGN KEY(equipment) REFERENCES Equipment(id)," +
                "   FOREIGN KEY(category) REFERENCES WorkoutCategory(catID))")
    }
    
    /* ********************************************************************************** */
    
    static func createWorkoutCatTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "WorkoutCategory( " +
                "   catID int primary key, " +
            "   catName text )")
    }
    
    /* ********************************************************************************** */
    
    static func createWorkoutImgTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "WorkoutImg( " +
                "   id int primary key, " +
                "   imgurl text, " +
                "   exerciseID int, " +
            "   FOREIGN KEY(exerciseID) REFERENCES Workout(workoutID))")
    }
    
    /* ********************************************************************************** */
    
    static func createEquipmentTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "Equipment( " +
                "   id int primary key, " +
            "   name text )")
    }
    
    /* ********************************************************************************** */
    
    static func createWorkoutCommentTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "WorkoutComment( " +
                "   id int primary key, " +
                "   comment text, " +
                "   exercise int, " +
            "   FOREIGN KEY(exercise) REFERENCES Workout(workoutID) )")
    }
    
    /* ********************************************************************************** */

    /* ********************************************************************************** */
}
