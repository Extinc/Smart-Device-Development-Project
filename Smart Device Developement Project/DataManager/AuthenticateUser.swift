//
//  AuthenticateUser.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 10/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//
	import UIKit
import FirebaseAuth
import FirebaseDatabase
class AuthenticateUser: NSObject {
    static func getUID()->String{
        var uid: String!
        if Auth.auth().currentUser!.uid.isEmpty == false && Auth.auth().currentUser!.uid != nil {
            uid = Auth.auth().currentUser!.uid
        }

        return uid
    }
    
    static func getCurrEmail()-> String{
        var email: String!
        if Auth.auth().currentUser!.email!.isEmpty == false && Auth.auth().currentUser!.email != nil {
	            email = Auth.auth().currentUser!.email
        }
        return email
    }
    
    static func getHeight(onComplete: ((_ : Double) -> Void)?){
        var height: Double!
        var heightStr: String!
        let ref = FirebaseDatabase.Database.database().reference().child("Profile").child(self.getUID()).child("height")
        print("Height uid: ", self.getUID())
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        
        print(ref)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {return}
            
            //print("Snapshot : ", Double(snapshot.value! as! String))
            height = Double(snapshot.value! as! String)
            onComplete!(height)
        })
    }
    
    static func getWeight(onComplete: ((_ : Double) -> Void)?){
        var weight: Double!
        let ref = FirebaseDatabase.Database.database().reference().child("Profile").child(self.getUID()).child("weight")
        print("Height uid: ", self.getUID())
        // observeSingleEventOfType tells Firebase
        // to load the full list of Movies, and execute the
        // "with" closure once, when the download
        // is complete.
        //
        
        print(ref)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {return}
            
            //print("Snapshot : ", Double(snapshot.value! as! String))
            weight = Double(snapshot.value! as! String)
            onComplete!(weight)
        })
    }
    
    static func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    static func getAccountProfile()-> AccountProfile{
        var accInfo: AccountProfile!
        
        var uid = self.getUID()
        var email = self.getCurrEmail()

        return accInfo
    }
}

class AccountProfile: NSObject {
    var email: String
    var heightNweight: [Double]
    
    init(email: String, hNw: [Double]){
        self.email = email
        self.heightNweight = hNw
    }
}
