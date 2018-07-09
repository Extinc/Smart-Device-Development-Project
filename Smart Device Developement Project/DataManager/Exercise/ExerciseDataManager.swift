//
//  ExerciseDataManager.swift
//  TestApp
//
//  Created by lim kei yiang on 14/6/18.
//  Copyright © 2018 NYP. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    
    // Get from firebase
    
    static func getExercise(onComplete: ((_ : [Exercise]) -> Void)?) {
        var eqList : [Exercise] = []
        
        let ref = FirebaseDatabase.Database.database().reference().child("Exercise/")
        
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            // This is the "with" closure that
            // executes only when the retrieval
            // of data from Firebase is complete.
            // Meanwhile, before the download is complete,
            // the user can still interact with the user
            // interface.
            //
            

            for record in snapshot.children
            {
                let r = record as! DataSnapshot
                let imglistcount = Int(r.childSnapshot(forPath: "Img").childrenCount)
                var imgList: [String] = []
                for i in 0...imglistcount-1{
                    imgList.append(r.childSnapshot(forPath: "Img").childSnapshot(forPath: "\(i)").childSnapshot(forPath: "image").value as! String)
                }
                
                let name = r.childSnapshot(forPath: "Title").value as! String
                var equipment: Int = getEquipID(name: r.childSnapshot(forPath: "Equipment").value as! String)
                let desc = r.childSnapshot(forPath: "Instructions").value as! String
                var category: Int = getCatID(name: r.childSnapshot(forPath: "Muscle").value as! String)
                var videoLink = ""
                let type = r.childSnapshot(forPath: "Type").value as! String
                let muscleImgLink = r.childSnapshot(forPath: "ImgMuscle").value as! String
                var level = r.childSnapshot(forPath: "Level").value as! String
                level = substringLevel(level: level)
                
                if  r.childSnapshot(forPath: "Video").exists() {
                    videoLink = r.childSnapshot(forPath: "Video").value as! String
                } else {
                    videoLink = ""
                }
                
                eqList.append(Exercise(id: Int(r.key)!, name: name, equipment: equipment, desc: desc, category: category, videoLink: videoLink as! String, imageLink: imgList, type: type, muscleImg: muscleImgLink, level: level
                ))
                print(imgList)
            }
            onComplete?(eqList)
        })
    }
    
    // TODO: For testing purpose
    static func testGetFirebase(){
        var eqList : [Exercise] = []
        
        let ref = FirebaseDatabase.Database.database().reference().child("Exercise/")
        
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // This is the "with" closure that
            // executes only when the retrieval
            // of data from Firebase is complete.
            // Meanwhile, before the download is complete,
            // the user can still interact with the user
            // interface.
            //
            for record in snapshot.children
            {
                let r = record as! DataSnapshot
                let imglistcount = Int(r.childSnapshot(forPath: "Img").childrenCount)
                var imgList: [String] = []
                for i in 0...imglistcount-1{
                    imgList.append(r.childSnapshot(forPath: "Img").childSnapshot(forPath: "\(i)").childSnapshot(forPath: "image").value as! String)
                    
                }
                
                
                
            }
        })
    }
    
    static func testgetExercise(catID: Int){
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Workout WHERE category = \(catID) GROUP BY Workout.name")
        
        for row in exRows {
             //var muscPri = row["imgurls"] as! String
            //muscPri.removeFirst()
           // muscPri.removeLast()
           //√ print("YO: \(convertArrInStringToStrArr(sArray: muscPri))")
            /*exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     equipment: row["equipment"] as! Int,
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int,
                                     videoLink: row["videolink"] as! String,
                                     imageLink: <#T##[String]#>,
                                     type: row["type"] as! String,
                                     muscleImg: row["muscleimgurls"] as! String))*/
        }
    }
    
    static func getEquipment(onComplete: ((_ : [Equipment]) -> Void)?){
    // create an empty list.
        var eqList : [Equipment] = []
    
        let ref = FirebaseDatabase.Database.database().reference().child("Equipment/")
    
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
    
        // This is the "with" closure that
        // executes only when the retrieval
        // of data from Firebase is complete.
        // Meanwhile, before the download is complete,
        // the user can still interact with the user
        // interface.
        //
            for record in snapshot.children
            {
                let r = record as! DataSnapshot
    
                eqList.append(Equipment(id: Int(r.key)!, name:  r.childSnapshot(forPath: "name").value as! String))
            }
            onComplete?(eqList)
        })
        
    }
    
    static func getCategory(onComplete: ((_ : [ExerciseCategory]) -> Void)?){
        // create an empty list.
        var eqList : [ExerciseCategory] = []
        
        let ref = FirebaseDatabase.Database.database().reference().child("Muscles/")
        
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            // This is the "with" closure that
            // executes only when the retrieval
            // of data from Firebase is complete.
            // Meanwhile, before the download is complete,
            // the user can still interact with the user
            // interface.
            //
            for record in snapshot.children
            {
                let r = record as! DataSnapshot
                
                eqList.append(ExerciseCategory(id: Int(r.key)!, name:  r.childSnapshot(forPath: "name").value as! String))
            }
            onComplete?(eqList)
        })
        
    }
    
    
    // *************************************************************************************
    //  Below is Code for SQLite Database
    // *************************************************************************************
    
    static func insertOrReplace(tableName: String, tableCols: String,valuesql: String, params: [Any]?){
        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO \(tableName) (\(tableCols)) VALUES (\(valuesql))",
                                        parameters: params!)
    }
    /* ********************************************************************************** */		
    
    static func loadExercise()->[Exercise]{
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Workout")
        
        for row in exRows {
            var imgurls = row["imgurls"] as! String
            imgurls.removeFirst()
            imgurls.removeLast()
            
            exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     equipment: row["equipment"] as! Int,
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int,
                                     videoLink: row["videolink"] as! String,
                                     imageLink: convertArrInStringToStrArr(sArray: imgurls),
                                     type: row["type"] as! String,
                                     muscleImg: row["muscleimgurls"] as! String,
                                     level: row["level"] as! String))
        }
        
        return exercise
    }
    
    static func loadExerciseOfCat(catID: Int) -> [Exercise]{
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Workout WHERE category = \(catID) GROUP BY Workout.name")
        
        for row in exRows {
           var imgurls = row["imgurls"] as! String
            imgurls.removeFirst()
            imgurls.removeLast()
            
            exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     equipment: row["equipment"] as! Int,
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int,
                                     videoLink: row["videolink"] as! String,
                                     imageLink: convertArrInStringToStrArr(sArray: imgurls),
                                     type: row["type"] as! String,
                                     muscleImg: row["muscleimgurls"] as! String,
                                     level: row["level"] as! String))
        }
        
        return exercise
    }
    
    static func loadExerciseOfLevel(level: String) -> [Exercise]{
        var exercise : [Exercise] = []
        let exRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Workout WHERE level = '\(level)' COLLATE NOCASE GROUP BY Workout.name ")
        
        for row in exRows {
            var imgurls = row["imgurls"] as! String
            imgurls.removeFirst()
            imgurls.removeLast()
            
            exercise.append(Exercise(id: row["workoutID"] as! Int,
                                     name: row["name"] as! String,
                                     equipment: row["equipment"] as! Int,
                                     desc: row["description"] as! String,
                                     category: row["category"] as! Int,
                                     videoLink: row["videolink"] as! String,
                                     imageLink: convertArrInStringToStrArr(sArray: imgurls),
                                     type: row["type"] as! String,
                                     muscleImg: row["muscleimgurls"] as! String,
                                     level: row["level"] as! String))
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
    
    static func getEquipmentById(id: Int) -> Equipment{
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * " +
            "FROM Equipment WHERE id = \(id) COLLATE NOCASE")
        
        var category : Equipment?
        for row in categoryRows
        {
            category = Equipment(id: row["id"] as! Int, name: row["name"] as! String)
        }
        return category!;
    }
    
    static func getEquipID(name: String) -> Int{
        let categoryRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT id " +
            "FROM Equipment WHERE name = '\(name)' COLLATE NOCASE")
        
        var category : Int = 0
        for row in categoryRows
        {
            category = row["id"] as! Int
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
            getCategory{ (cat) in
                for i in cat {
                    let id : Int = i.id!
                    let name : String = i.name!
                    insertOrReplace(
                        tableName: "WorkoutCategory",
                        tableCols: " catID, catName ",
                        valuesql: "?,?",
                        params: [id, name])
                }
            }
        }
    }
    
    /* ********************************************************************************** */
    
    static func insertExerciseToDB(){
        if checkIfTableHasRows(tableName: "Workout") == false {
            getExercise { (exercise) in
                for e in exercise {
                    insertOrReplace(
                        tableName: "Workout",
                        tableCols: " workoutID, name, equipment, description, category, type, level, videolink, imgurls, muscleimgurls ",
                        valuesql: "?,?,?,?,?,?,?,?,?,?",
                        params: [e.id, e.name, e.equipment, e.desc!, e.category!, e.type!, e.level!, e.videoLink!, "\(e.imageLink)", e.muscleImg!])
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
        if checkIfTableHasRows(tableName: "Equipment") == false {
            getEquipment { (equip) in
                for i in equip {
                    let id : Int = i.id!
                    let name : String = i.name!
                    insertOrReplace(
                        tableName: "Equipment",
                        tableCols: " id, name ",
                        valuesql: "?,?",
                        params: [id, name])
                }
            }
        }
    }
    
    /* ********************************************************************************** */
    
    static func insertWorkoutCommentToTable(){
        if checkIfTableHasRows(tableName: "WorkoutComment") == false {
            HTTP_Auth.getJSON(url: "\(ExerciseDataManager.init().apiLink)/exercisecomment/?language=2&limit=300", token: ExerciseDataManager.init().AuthorizationToken) {
                (json, response, error) in
                if error != nil{
                    return
                }
                let numResults: Int = json!["results"].count
                for j in 0...numResults{
                    if json!["results"][j]["id"].int != nil{
                        let id : Int = json!["results"][j]["id"].int!
                        let comment : String = json!["results"][j]["comment"].string!
                        let exid : Int = json!["results"][j]["exercise"].int!
                        insertOrReplace(
                            tableName: "WorkoutComment",
                            tableCols: " id, comment, exercise ",
                            valuesql: "?,?,?",
                            params: [id, comment, exid])
                    }
                }
            }
        }
    }
    
    
    //
    
    
    
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
    
    // Below is to Convert Array inside string into String Array
   
    static func convertArrInStringToStrArr(sArray: String) -> [String]{
        var array1 = sArray
        
        array1.removeFirst()
        array1.removeLast()
        array1 = array1.replacingOccurrences(of: ",", with: "")
        array1 = array1.replacingOccurrences(of: "\"", with: "")
        let sArray1 = array1.split(separator: " ")
        let intArray = sArray1.map {String($0)}
        
        return intArray
    }
 
    static func substringLevel(level: String) -> String{
        let str = "level:"
        let index = level.index(after: str.endIndex)
        let sub = level[index...]
        
        return String(sub)
    }
}

