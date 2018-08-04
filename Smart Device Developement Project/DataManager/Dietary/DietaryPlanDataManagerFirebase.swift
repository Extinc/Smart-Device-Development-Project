//
//  DietaryPlanDataManagerFirebase.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 5/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class DietaryPlanDataManagerFirebase: NSObject {

    //MARK: - Meal
    //Load Meal "table"
    static func loadMeals(onComplete: @escaping ([Meal]) -> Void){
        //Create empty list
        var mealList : [Meal] = []
        let ref = FirebaseDatabase.Database.database().reference().child("Meal/")
        
        ref.observeSingleEvent(of: .value, with:{(snapshot) in
                for record in snapshot.children {
                    let r = record as! DataSnapshot
                    let id = Int(r.key)!
                    let image = r.childSnapshot(forPath: "image").value as! String
                    let name = r.childSnapshot(forPath: "name").value as! String
                    let calories = Float(r.childSnapshot(forPath: "calories").value as! String)!
                    let carbohydrates = Float(r.childSnapshot(forPath: "carbohydrates").value as! String)!
                    let protein = Float(r.childSnapshot(forPath: "protein").value as! String)!
                    let fat = Float(r.childSnapshot(forPath: "fat").value as! String)!
                    let sodium = Float(r.childSnapshot(forPath: "sodium").value as! String)!
                    let ingredients = r.childSnapshot(forPath: "ingredients").value as! String
                    let imageRecipe = r.childSnapshot(forPath: "imageRecipe").value as! String
                    let hawkercentres = r.childSnapshot(forPath: "hawkercentres").value as! String
                    mealList.append(Meal(id, image, name, calories, carbohydrates, protein, fat, sodium, ingredients, imageRecipe, hawkercentres))
                }
            onComplete(mealList)
        })
    }
    
    static func loadOneMeal(id: Int, onComplete: @escaping (Meal) -> Void){
        
        var meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
        let ref = FirebaseDatabase.Database.database().reference().child("Meal/")
        ref.observeSingleEvent(of: .value, with:{(snapshot) in
            for record in snapshot.children {
                let r = record as! DataSnapshot
                let mid = Int(r.key as! String)
                let image = r.childSnapshot(forPath: "image").value as! String
                let name = r.childSnapshot(forPath: "name").value as! String
                let calories = Float(r.childSnapshot(forPath: "calories").value as! String)!
                let carbohydrates = Float(r.childSnapshot(forPath: "carbohydrates").value as! String)!
                let protein = Float(r.childSnapshot(forPath: "protein").value as! String)!
                let fat = Float(r.childSnapshot(forPath: "fat").value as! String)!
                let sodium = Float(r.childSnapshot(forPath: "sodium").value as! String)!
                let ingredients = r.childSnapshot(forPath: "ingredients").value as! String
                let imageRecipe = r.childSnapshot(forPath: "imageRecipe").value as! String
                let hawkercentres = r.childSnapshot(forPath: "hawkercentres").value as! String
                
                if (id == mid){
                    meal = Meal(mid!, image, name, calories, carbohydrates, protein, fat, sodium, ingredients, imageRecipe, hawkercentres)
                }
                
            }
            onComplete(meal)
        })
    }
    
    //Create / Update
    static func createMealData() {
        let ref1 = FirebaseDatabase.Database.database().reference().child("Meal/\(1)/")
        ref1.setValue([
            "name" : "Chicken Rice",
            "image": "chickenrice",
            "calories" : "510",
            "carbohydrates" : "45.6",
            "protein" : "45.7",
            "fat" : "16.5",
            "sodium" : "1112.23",
            "ingredients" : "Chicken breast, ginger, white rice, brown rice, canola oil, garlic, Pandan leaf, sesame oil, chicken seasoning powder",
            "imageRecipe" : "chickenricerecipe",
            "hawkercentres" : "1, 2, 5, 9"
            ]
        )
        
        let ref2 = FirebaseDatabase.Database.database().reference().child("Meal/\(2)/")
        ref2.setValue([
            "name" : "Black Carrot Cake",
            "image": "blackcarrotcake",
            "calories" : "556.47",
            "carbohydrates" : "65.77",
            "protein" : "13.16",
            "fat" : "26.74",
            "sodium" : "1937.08",
            "ingredients" : "Daikon, Vegetable oil, salt, white pepper, rice flour, eggs, garlic, soy sauce, Sriracha, Scallions, cilantro",
            "imageRecipe" : "blackcarrotcakerecipe",
            "hawkercentres" : "2, 3, 4, 5, 9"
            ])
        
        let ref3 = FirebaseDatabase.Database.database().reference().child("Meal/\(3)/")
        ref3.setValue([
            "name" : "Chilli Chicken Pasta",
            "image": "chillichickenpasta",
            "calories" : "466",
            "carbohydrates" : "76",
            "protein" : "35",
            "fat" : "5.5",
            "sodium" : "300",
            "ingredients" : "wholegrain pasta, corn, celery, olive oil, chicken breast, chilli powder, chicken seasoning, pepper, tomatoes, lime, parsley",
            "imageRecipe" : "chillichickenpastarecipe",
            "hawkercentres" : "1, 4, 6, 8"
            
            ])
        
        let ref4 = FirebaseDatabase.Database.database().reference().child("Meal/\(4)/")
        ref4.setValue([
            "name" : "Curry Chicken",
            "image": "currychicken",
            "calories" : "364",
            "carbohydrates" : "22.2",
            "protein" : "39",
            "fat" : "12.8",
            "sodium" : "350",
            "ingredients" : "chicken leg, onions, chilli powder, turmeric powder, green capsicum, salt, pepper, sunflower oil, evaporated milk, curry leaves",
            "imageRecipe" : "currychickenrecipe",
            "hawkercentres" : "1, 2, 5, 6, 7"
            ])
        
        let ref5 = FirebaseDatabase.Database.database().reference().child("Meal/\(5)/")
        ref5.setValue([
            "name" : "Fried Olive Rice",
            "image": "friedoliverice",
            "calories" : "323",
            "carbohydrates" : "40",
            "protein" : "12.8",
            "fat" : "12.4",
            "sodium" : "310",
            "ingredients" : "olive oil, garlic, minced meat, chinese olives, long beans, brown rice, basmati rice, red chilli, cashews, sesame oil",
            "imageRecipe" : "friedolivericerecipe",
            "hawkercentres" : "2, 3, 4, 5, 6, 9"
            ])
        
        let ref6 = FirebaseDatabase.Database.database().reference().child("Meal/\(6)/")
        ref6.setValue([
            "name" : "Mee Goreng",
            "image": "meegoreng",
            "calories" : "220",
            "carbohydrates" : "28",
            "protein" : "13",
            "fat" : "7.2",
            "sodium" : "370",
            "ingredients" : "canola oil, chilli paste, garlic, shallots, dried shrimp, minced meat, prawns, chye sim, yellow noodles, cabbage, bean sprouts, tomato sauce, stalks onions",
            "imageRecipe" : "meegorengrecipe",
            "hawkercentres" : "1, 2, 3, 4, 5, 6, 7, 8, 9"
            ])
        
        let ref7 = FirebaseDatabase.Database.database().reference().child("Meal/\(7)/")
        ref7.setValue([
            "name" : "Mini Speedy Pizzas",
            "image": "minipizzas",
            "calories" : "205",
            "carbohydrates" : "36.4",
            "protein" : "11.2",
            "fat" : "3.4",
            "sodium" : "800.5",
            "ingredients" : "tomato pasta sauce, wholemeal bread, low-fat cheese, chicken cubes, white mushroom, eggplant, capsicum",
            "imageRecipe" : "minipizzasrecipe",
            "hawkercentres" : "1, 4, 7, 8"
            ])
        
        let ref8 = FirebaseDatabase.Database.database().reference().child("Meal/\(8)/")
        ref8.setValue([
            "name" : "Sardine Fried Rice",
            "image": "sardinefriedrice",
            "calories" : "323",
            "carbohydrates" : "38.7",
            "protein" : "14.9",
            "fat" : "11.9",
            "sodium" : "480",
            "ingredients" : "Sardines, canola oil, onion, garlic, vegetables, rice, pepper, eggs",
            "imageRecipe" : "sardinefriedricerecipe",
            "hawkercentres" : "1, 2, 4, 5"
            ])
        
        let ref9 = FirebaseDatabase.Database.database().reference().child("Meal/\(9)/")
        ref9.setValue([
            "name" : "Sliced Fish Bee Hoon Soup",
            "image": "beehoonsoup",
            "calories" : "385",
            "carbohydrates" : "55.2",
            "protein" : "21.1",
            "fat" : "8.8",
            "sodium" : "470",
            "ingredients" : "fish fillet, brown rice bee hoon, tomatoes, spring onions, ginger, corn oil, sesame oil, evaporated milk, fish stock seasoning, pepper",
            "imageRecipe" : "beehoonsouprecipe",
            "hawkercentres" : "1, 2, 3, 4, 7, 9"
            ])
        
        let ref10 = FirebaseDatabase.Database.database().reference().child("Meal/\(10)/")
        ref10.setValue([
            "name" : "Teriyaki Salmon and Pasta",
            "image": "salmonpasta",
            "calories" : "378",
            "carbohydrates" : "39.2",
            "protein" : "26.9",
            "fat" : "13.4",
            "sodium" : "375",
            "ingredients" : "capsicum, canola oil, salmon fillet, teriyaki marinade, black and white sesame seeds, wholemeal pasta, olive oil, cucumber, lime, pepper",
            "imageRecipe" : "salmonpastarecipe",
            "hawkercentres" : "4, 7, 8, 9"
            ])
        
        
    }
    
    //MARK: - Meal Plan
    
    //Load Meal Plan "table"
    static func loadMealPlans(date: String, username: String, onComplete: @escaping ([MealPlan]) -> Void) {
        //Create empty list
        var mealPlanList : [MealPlan] = []
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(username).child(date)
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                
                let exists: Bool = snapshot.exists()
                
                if (exists == true){
                    for record in snapshot.children {
                        let r = record as! DataSnapshot
                        let planid = Int(r.key as! String)!
                        let mealid = r.childSnapshot(forPath: "mealID").value as! Int
                        let mealname = r.childSnapshot(forPath: "mealName").value as! String
                        let mealimage = r.childSnapshot(forPath: "mealImage").value as! String
                        let calories = r.childSnapshot(forPath: "calories").value as! Double
                        let isDiary = r.childSnapshot(forPath: "isDiary").value as! String
                        let recipeimage = r.childSnapshot(forPath: "recipeImage").value as! String
                        let fCalories = Float(calories)
                        let planType = r.childSnapshot(forPath: "planType").value as! String
                        let count = r.childSnapshot(forPath: "count").value as! Int
                        
                        mealPlanList.append(MealPlan(username,planid, date,mealid,mealname,mealimage,fCalories,recipeimage,isDiary, planType, count))
                        
                    }
                }
                else {
                    mealPlanList.append(MealPlan("",0 ,"",0,"","",0,"", "", "", 0))
                }
            onComplete(mealPlanList)
        })
    }
    
    static func loadMealPlansCount(date: String, username: String, onComplete: @escaping (Int) -> Void){
        var count: Int = 0
        //Create empty list
        var mealPlanList : [MealPlan] = []
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(username).child(date)
        
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
            for record in snapshot.children{
                let r = record as! DataSnapshot
                let isDiary = r.childSnapshot(forPath: "isDiary").value as! String
                if(isDiary == "No") {
                    count = count + 1
                }
            }
            onComplete(count)
        })
        
    }
    
    static func loadPlanID(date: String, username: String, onComplete: @escaping (Int) -> Void){
        var arrayOfID: [Int] = []
        var planID: Int = 0
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(username).child(date)
        
        
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                let exists: Bool = snapshot.exists()
                
                if (exists == true){
                    for record in snapshot.children{
                        let r = record as! DataSnapshot
                        let planid = Int(r.key as! String)!
                        arrayOfID.append(planid)
                    }
                    for i in 0...arrayOfID.count - 1 {
                        planID = arrayOfID[i]
                    }
                    
                    
                }else {
                    planID = 0
                }
                onComplete(planID)
        })
    }
    
    static func loadOneMealPlan(date: String, username: String, mealID: Int, onComplete: @escaping (MealPlan) -> Void){
        var mealPlan : MealPlan = MealPlan("", 0, "", 0, "", "", 0, "", "", "", 0)
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(username).child(date)
        
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                
                let exists: Bool = snapshot.exists()
                if (exists == true){
                    for record in snapshot.children{
                        let r = record as! DataSnapshot
                        let planid = Int(r.key)!
                        let mealid = r.childSnapshot(forPath: "mealID").value as! Int
                        let mealname = r.childSnapshot(forPath: "mealName").value as! String
                        let mealimage = r.childSnapshot(forPath: "mealImage").value as! String
                        let calories = r.childSnapshot(forPath: "calories").value as! Double
                        let isDiary = r.childSnapshot(forPath: "isDiary").value as! String
                        let recipeimage = r.childSnapshot(forPath: "recipeImage").value as! String
                        let fCalories = Float(calories)
                        let planType = r.childSnapshot(forPath: "planType").value as! String
                        let count = Int(r.childSnapshot(forPath: "count").value as! String)!
                        
                        if(isDiary == "Yes") {
                            if(mealid == mealID){
                                mealPlan = MealPlan(username, planid, date, mealid, mealname, mealimage, fCalories, recipeimage, isDiary, planType, count)
                            }
                        }
                    }
                }
                
                onComplete(mealPlan)
        })
    }
    
    
    static func loadPlanType(date: String, username: String, onComplete: @escaping (String) -> Void){
        var planType: String = ""
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(username).child(date)
        
        
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                let exists: Bool = snapshot.exists()
                
                if (exists == true){
                    for record in snapshot.children{
                        let r = record as! DataSnapshot
                        let planid = Int(r.key as! String)!
                        let isDiary = r.childSnapshot(forPath: "isDiary").value as! String
                        let pType = r.childSnapshot(forPath: "planType").value as! String
                        
                        if(isDiary == "No"){
                           planType = pType
                        }
                    }
                }else {
                    
                }
                onComplete(planType)
        })
    }
    
    
  
    
    
    //Create / Update
    static func createPlanData(mealPlanList: [MealPlan]) {
        for i in 0...mealPlanList.count - 1{
            let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(mealPlanList[i].username!).child(mealPlanList[i].date!).child(String(mealPlanList[i].planID!))
            ref.setValue([
                "mealID" : mealPlanList[i].mealID,
                "mealName" : mealPlanList[i].mealName,
                "mealImage" : mealPlanList[i].mealImage,
                "calories" : mealPlanList[i].calories,
                "isDiary" : mealPlanList[i].isDiary,
                "recipeImage" : mealPlanList[i].recipeImage,
                "planType" : mealPlanList[i].planType,
                "count" : mealPlanList[i].count
                ]
            )
        }
    }
    
    static func updatePlan(mealPlan: MealPlan) {
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(mealPlan.username!).child(mealPlan.date!).child(String(mealPlan.planID!))
        ref.setValue([
            "mealID" : mealPlan.mealID,
            "mealName" : mealPlan.mealName,
            "mealImage" : mealPlan.mealImage,
            "calories" : mealPlan.calories,
            "isDiary" : mealPlan.isDiary,
            "recipeImage" : mealPlan.recipeImage,
            "planType" : mealPlan.planType,
            "count" : mealPlan.count
            ]
        )
    }
    
    //Delete
    static func deleteMealPlan(_ mealPlan: MealPlan){
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan").child(mealPlan.username!).child(mealPlan.date!).child(String(mealPlan.planID!))
        ref.removeValue()
    }
    
    //MARK: - Hawker Centres
    
    //Load Meal "table"
    static func loadHawkerCentres(onComplete: @escaping ([HawkerCentres]) -> Void){
        //Create empty list
        var hawkerCentreList : [HawkerCentres] = []
        let ref = FirebaseDatabase.Database.database().reference().child("HawkerCentres/")

        ref.observeSingleEvent(of: .value, with:{(snapshot) in
            for record in snapshot.children {
                let r = record as! DataSnapshot
                let id = Int(r.key)!
                let name = r.childSnapshot(forPath: "name").value as! String
                let address = r.childSnapshot(forPath: "address").value as! String
                let longitude = Double(r.childSnapshot(forPath: "longitude").value as! String)!
                let latitude = Double(r.childSnapshot(forPath: "latitude").value as! String)!
                hawkerCentreList.append(HawkerCentres(id, name, latitude, longitude, address))
               
            }
            onComplete(hawkerCentreList)
        })
        
        
    }
    
    
    static func createHawkerData() {
        let ref1 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(1)/")
        ref1.setValue([
            "name" : "Marsiling Mall Hawker Centre",
            "address": "Blk 4,Woodlands St 12,Singapore 738623",
            "description" : "Built in 2017, and located close to the heart of Woodlands, Marsiling Mall Hawker Centre offers residents convenient access to a variety of good and affordable hawker food. This hawker centre is also situated adjacent to Woodlands Sports Centre, bringing hawker food to the doorstep of sports facility users.",
            "latitude" : "1.433543",
            "longitude" : "103.779881"
            ]
        )
        
        let ref2 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(2)/")
        ref2.setValue([
            "name" : "Sembawang Hills Food Centre (Jalan Leban Food Centre)",
            "address": "590, Upper Thomson Road, Singapore 574419",
            "description" : "Built in 1974, this centre is nestled along Upper Thomson Road and offers a wide variety of food such as Fish / Seafood Soup, Char Kway Teow, Ngoh Hiang, Pasta etc. The centre comprises 36 cooked food stalls.",
            "latitude" : "1.37241995",
            "longitude" : "103.8290329"
            ]
        )
        let ref3 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(3)/")
        ref3.setValue([
            "name" : "Ang Mo Kio Ave 4 Blk 628 (Ang Mo Kio 628 Market)",
            "address": "Blk 628, Ang Mo Kio Ave 4, Singapore 560628",
            "description" : "Originally built in 1979, the hawker centre is located opposite Yio Chu Kang CC and near schools, temples and residential flats. After the upgrading in 2010, the rebuilt centre consists of 52 cooked food stalls and 166 market stalls to serve the marketingand dining needs of patrons.",
            "latitude" : "1.38066268",
            "longitude" : "103.8407516"
            ]
        )
        let ref4 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(4)/")
        ref4.setValue([
            "name" : "Ang Mo Kio Ave 4 Blk 160/162 (Mayflower Market)",
            "address": "Blk 160/162, Ang Mo Kio Ave 4, Singapore 560160/560162",
            "description" : "Commonly known as Mayflower Market, the hawker centre was built in 1981. It comprises 40 cooked food stalls and 84 market stalls to serve the marketing and dining needs of residents.",
            "latitude" : "1.37460005",
            "longitude" : "103.839241"
            ]
        )
        let ref5 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(5)/")
        ref5.setValue([
            "name" : "Ang Mo Kio Ave 6 Blk 724 (Blk 724 Ang Mo Kio Market)",
            "address": "Blk 724, Ang Mo Kio Ave 6, Singapore 560724",
            "description" : "Located conveniently in the heart of the bustling Ang Mo Kio Town Centre, the hawker centre is always packed with patrons, especially during the weekends. Be prepared to queue for your favourite food at popular stalls!",
            "latitude" : "1.37204003",
            "longitude" : "103.8464966"
            ]
        )
        let ref6 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(6)/")
        ref6.setValue([
            "name" : "Ang Mo Kio Ave 10 Blk 527 (Cheng San Market and Cooked Food Centre)",
            "address": "Blk 527, Ang Mo Kio Ave 10, Singapore 560527",
            "description" : "Commonly known as Cheng San Market and Cooked Food Centre, Blk 527 Ang Mo Kio Ave 10 is one of the three hawker centres located along Ang Mo Kio Ave 10. The hawker centre was built in 1979 to serve the dining and marketing needs of nearby residents. Upgraded in 2004, it houses 50 cooked food stalls and 100 market stalls.",
            "latitude" : "1.37270999",
            "longitude" : "103.8544464"
            ]
        )
        let ref7 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(7)/")
        ref7.setValue([
            "name" : "Ang Mo Kio Ave 1 Blk 341 (Teck Ghee Court)",
            "address": "Blk 341, Ang Mo Kio Ave 1, Singapore 560341",
            "description" : "Located in the heart of Teck Ghee estate and opposite Bishan Park, the 32 cooked food stalls and 86 market stalls within the hawker centre remain a popular choice among patrons despite the availability of alternative marketing and dining facilities nearby. Popular local dishes are whipped up daily to satisfy patrons' desires for good food!",
            "latitude" : "1.36416996",
            "longitude" : "103.84832"
            ]
        )
        let ref8 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(8)/")
        ref8.setValue([
            "name" : "Ang Mo Kio Ave 10 Blk 409 (Teck Ghee Square)",
            "address": "Blk 409, Ang Mo Kio Ave 10, Singapore 560409",
            "description" : "Also known as Teck Ghee Square, it is one of the three hawker centres that are situated along Ang Mo Kio Ave 10. Built in 1979, the hawker centre comprises 40 cooked food stalls and 148 market stalls.",
            "latitude" : "1.36273003",
            "longitude" : "103.8553772"
            ]
        )
        let ref9 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(9)/")
        ref9.setValue([
            "name" : "Ang Mo Kio Ave 10 Blk 453A (Chong Boon Market and Food Centre)",
            "address": "Blk 453A, Ang Mo Kio Ave 10, Singapore 561453",
            "description" : "Built in 1979, the hawker centre at Blk 453A Ang Mo Kio Ave 10 consists of 38 cooked food stalls and 184 market stalls.",
            "latitude" : "1.36829995999999",
            "longitude" : "103.8564377"
            ]
        )
        let ref10 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(10)/")
        ref10.setValue([
            "name" : "Chomp Chomp Food Centre",
            "address": "20, Kensington Park Road, Singapore 557269",
            "description" : "Located in Serangoon Gardens, Chomp Chomp Food Centre is well-known for its vibrant dinner and supper scene. Bustling with diners even till late at night, the 36 cooked food stalls in the small hawker centre serve popular local dishes such as Char Kway Teow, BBQ Chicken Wings, Seafood etc. This Centre attracts food lovers from all over the island.",
            "latitude" : "1.36422801",
            "longitude" : "103.8665314"
            ]
        )
    }
   
}
