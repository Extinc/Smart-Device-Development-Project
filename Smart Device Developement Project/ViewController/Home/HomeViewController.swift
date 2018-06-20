 //
//  HomeViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userID: String? = Auth.auth().currentUser!.uid
        let email: String? = Auth.auth().currentUser!.email!
        print(email!)
        
        // Do any additional setup after loading the view.
        
        // Below is Database code
        
        //
        // For workout
        //
        DataManager.createTable(sql:
            "CREATE TABLE IF NOT EXISTS " +
            "WorkoutCategory( " +
            "   catID int primary key, " +
            "   catName text )")
        
        // To insert data from api/json into sqlite for quicker access.
        ExerciseDataManager.addExerciseCategoryToDB()
        //
        
        //
        // For User Info
        //
        
        if DataManager.checkUserExist(params: [userID!, email!]) == false {
            DataManager.insertUserInfo(uid: userID!, email: email!)
        }
        
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
