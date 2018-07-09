//
//  Authentication.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 9/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseAuth
class Authentication: NSObject {
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
}
