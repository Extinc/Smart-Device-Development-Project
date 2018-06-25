//
//  ExerciseDataManager.swift
//  TestApp
//
//  Created by lim kei yiang on 14/6/18.
//  Copyright © 2018 NYP. All rights reserved.
//

import UIKit

class ExerciseDataManager: NSObject{
    // *************************************************************************************
    //  Rest API
    //  Token for wger.de/api/v2/exercise/
    // *************************************************************************************
    let AuthorizationToken = "Token 1ca4117d3a597c00930fe0ac19c3ab8ffaef2557"
    //
    let apiLink = "https://wger.de/api/v2"
    
    class func getExerciseCategory(onComplete: ((_ : [ExerciseCategory]) -> Void)?){
        var ecList: [ExerciseCategory] = []
        HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercisecategory", token: ExerciseDataManager.init().AuthorizationToken) {
            (json, response, error) in
            if error != nil{
                return
            }
            let numResults: Int = json!["results"].count
            var sql = ""
            for j in 0...numResults{
                if json!["results"][j]["id"].int != nil{
                    let id: Int = json!["results"][j]["id"].int!
                    let name: String = json!["results"][j]["name"].string!
   
                    ecList.append(ExerciseCategory(id: id, name: name))
                }
            }
            print(json!)
            onComplete?(ecList)
        }
    }
    
    
    // *************************************************************************************
    //  Below is Code for Database
    // *************************************************************************************
    
    static func insertOrReplace(tableName: String, tableCols: String,valuesql: String, params: [Any]?){
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO \(tableName) (\(tableCols)) VALUES (\(valuesql))",
                                        parameters: params!)
    }
    /* ********************************************************************************** */		
    
    static func loadExercise()->[Exercise]{
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT workoutID, name, muscPri, muscSec, equipment, description, category " +
            "FROM Workout")
        
        for row in exRows {
            var muscPri = row["muscPri"] as! String
            muscPri.removeFirst()
            muscPri.removeLast()
            exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     musclesPri: convertArrInStringToIntArr(sArray: row["muscPri"] as! String),
                                     musclesSec: convertArrInStringToIntArr(sArray: row["muscSec"] as! String),
                                     equipId: convertArrInStringToIntArr(sArray: row["equipment"] as! String),
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int))
        }
        
        return exercise
    }
    
    static func loadExerciseOfCat(catID: Int) -> [Exercise]{
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Workout WHERE category = \(catID) GROUP BY Workout.name")
        
        for row in exRows {
            var muscPri = row["muscPri"] as! String
            muscPri.removeFirst()
            muscPri.removeLast()
            exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     musclesPri: convertArrInStringToIntArr(sArray: row["muscPri"] as! String),
                                     musclesSec: convertArrInStringToIntArr(sArray: row["muscSec"] as! String),
                                     equipId: convertArrInStringToIntArr(sArray: row["equipment"] as! String),
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int))
        }
        
        return exercise
    }
    
    static func loadCategory() -> [ExerciseCategory]
    {
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT catID, catName " +
            "FROM WorkoutCategory")
        
        var category : [ExerciseCategory] = []
        for row in categoryRows
        {
            category.append(ExerciseCategory(
                id : row["catID"] as! Int,
                name : row["catName"] as! String))
        }
        return category;
    }
    
    static func loadExerciseImg() -> [ExerciseImage]
    {
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM WorkoutCategory")
        
        var category : [ExerciseImage] = []
        for row in categoryRows
        {
            category.append(ExerciseImage(id: row["id"] as! Int,
                                          imageurl: row["imgurl"] as! String,
                                          exerciseID: row["exerciseID"] as! Int))
        }
        return category;
    }
    
    static func getCatID(name: String) -> Int{
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT catID " +
            "FROM WorkoutCategory WHERE catName = '\(name)' COLLATE NOCASE")
        
        var category : Int = 0
        for row in categoryRows
        {
            category = row["catID"] as! Int
        }
        return category;
    }
    
    // *************************************************************************************
    //  Inserting to Database table
    // *************************************************************************************
    
    static func addExerciseCategoryToDB(){
        if checkIfTableHasRows(tableName: "WorkoutCategory") == false {
            HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercisecategory", token: ExerciseDataManager.init().AuthorizationToken) {
                (json, response, error) in
                if error != nil{
                    return
                }
                let numResults: Int = json!["results"].count
                for j in 0...numResults{
                    if json!["results"][j]["id"].int != nil{
                        let id: Int = json!["results"][j]["id"].int!
                        let name: String = json!["results"][j]["name"].string!
                        insertOrReplace(tableName: "WorkoutCategory", tableCols: " catID, catName ", valuesql: "?,?", params: [id,name])
                    }
                }
            }
        }
    }
    
    /* ********************************************************************************** */
    
    static func insertExerciseToDB(){
        let eCat = loadCategory()
        let eCatID = eCat.map { (e) -> Int in
            e.id!
        }
        if checkIfTableHasRows(tableName: "Workout") == false {
            for i in eCatID {
                HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercise/?category=\(i)&limit=200&language=2", token: ExerciseDataManager.init().AuthorizationToken) {
                    (json, response, error) in
                    if error != nil{
                        return
                    }
                    let numResults: Int = json!["results"].count
                    for j in 0...numResults{
                        if json!["results"][j]["id"].int != nil{
                            let id : Int = json!["results"][j]["id"].int!
                            let name : String = json!["results"][j]["name"].string!
                            let muscPri : [Int] = json!["results"][j]["muscles"].arrayObject as! [Int]
                            let muscSec : [Int] = json!["results"][j]["muscles_secondary"].arrayObject as! [Int]
                            let equipment : [Int] = json!["results"][j]["equipment"].arrayObject as! [Int]
                            let description : String = json!["results"][j]["description"].string!
                            let category : Int = json!["results"][j]["category"].int!
                            if (name.isEmpty == false && name != "teste" && name != "Awesome" && name != "Test" && name != "Arms" && name != "Wyciskanie Skos" ) {
                                if ((muscPri.count >= 1 && muscSec.count >= 1) ||
                                    (muscPri.count >= 1 && muscSec.count >= 1)){
                                    print("Count: \(muscPri.count)")
                                    insertOrReplace(
                                        tableName: "Workout",
                                        tableCols: " workoutID, name, muscPri, muscSec, equipment, description, category ",
                                        valuesql: "?,?,?,?,?,?,?",
                                        params: [id, name, "\(muscPri)", "\(muscSec)", "\(equipment)", description, category])
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /* ********************************************************************************** */
    
    static func insertWorkoutImgUrlToTable(){
        if checkIfTableHasRows(tableName: "WorkoutImg") == false {
            HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exerciseimage/?language=2&limit=300", token: ExerciseDataManager.init().AuthorizationToken) {
                (json, response, error) in
                if error != nil{
                    return
                }
                let numResults: Int = json!["results"].count
                for j in 0...numResults{
                    if json!["results"][j]["id"].int != nil{
                        let id : Int = json!["results"][j]["id"].int!
                        let imgurl : String = json!["results"][j]["image"].string!
                        let exID : Int = json!["results"][j]["exercise"].int!
                        insertOrReplace(
                            tableName: "WorkoutImg",
                            tableCols: " id, imgurl, exerciseID ",
                            valuesql: "?,?,?",
                            params: [id, imgurl, exID])
                    }
                }
            }
        }
    }
    
    /* ********************************************************************************** */
    
    static func insertEquipmentListToTable(){
        if checkIfTableHasRows(tableName: "Equipment") {
            HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/equipment/?language=2&limit=300", token: ExerciseDataManager.init().AuthorizationToken) {
                (json, response, error) in
                if error != nil{
                    return
                }
                let numResults: Int = json!["results"].count
                for j in 0...numResults{
                    if json!["results"][j]["id"].int != nil{
                        let id : Int = json!["results"][j]["id"].int!
                        let name : String = json!["results"][j]["name"].string!
                        insertOrReplace(
                            tableName: "Equipment",
                            tableCols: " id, name ",
                            valuesql: "?,?",
                            params: [id, name])
                    }
                }
            }
        }
    }
    
    //
    
    // *************************************************************************************
    //  Creating Table for Database
    // *************************************************************************************
    
    static func createWorkoutTable(){
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
            "Workout( " +
            "   workoutID int primary key, " +
            "   name text, " +
            "   muscPri text, " +
            "   muscSec text, " +
            "   equipment text, " +
            "   description text, " +
            "   category int, " +
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
    
    // *************************************************************************************
    //  Check if database table have any rows
    // *************************************************************************************
    static func checkIfTableHasRows(tableName: String) -> Bool{
        let result = SQLiteDB.sharedInstance.query(sql:"SELECT COUNT(*) FROM \(tableName)")
        var count : Int = 0
        var hasRows : Bool = false
        for row in result{
            count = row["COUNT(*)"] as! Int
        }
        
        if count > 0 {
            hasRows = true
        } else {
            hasRows = false
        }
        
        return hasRows
    }
    
    // *************************************************************************************
    //  Convert Methods
    // *************************************************************************************
    
    // Below is to Convert Array inside string into Int Array
    static func convertArrInStringToIntArr(sArray: String) -> [Int]{
        var array1 = sArray
        
        array1.removeFirst()
        array1.removeLast()
        array1 = array1.replacingOccurrences(of: ",", with: "")
        let sArray1 = array1.split(separator: " ")
        let intArray = sArray1.map {Int($0)!}
        
        return intArray
    }
    
}

