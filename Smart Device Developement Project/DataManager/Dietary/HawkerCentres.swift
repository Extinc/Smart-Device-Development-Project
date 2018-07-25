//
//  HawkerCentres.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class HawkerCentres: NSObject {
    var hawkerID: Int?
    var hawkerName: String?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    
    
    init(_ hawkerID: Int ,_ hawkerName: String, _ latitude: Double, _ longitude: Double, _ address: String ){
        self.hawkerID = hawkerID
        self.hawkerName = hawkerName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }

}
