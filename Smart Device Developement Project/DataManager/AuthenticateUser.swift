//
//  AuthenticateUser.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 10/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseAuth
class AuthenticateUser: NSObject {
    static func getUID()->String{
        var uid: String!
        if Auth.auth().currentUser!.uid.isEmpty == false && Auth.auth().currentUser!.uid != nil {
            uid = Auth.auth().currentUser!.uid
        }
        return uid
    }
    
    static func getCurrEmail()-> String{
        var uid: String!
        if Auth.auth().currentUser!.email!.isEmpty == false && Auth.auth().currentUser!.email != nil {
            uid = Auth.auth().currentUser!.email
        }
        return uid
    }
    
    static func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

class Account: NSObject {
    var email: String!
    var password: String!
    var heightNweight: [Double]
    
    init(email: String, password: String, hNw: [Double]){
        self.email = email
        self.password = password
        self.heightNweight = hNw
    }
}
