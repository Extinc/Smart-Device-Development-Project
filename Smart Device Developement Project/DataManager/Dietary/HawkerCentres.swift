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
    var latitude: Float?
    var longitude: Float?
    var address: String?
    
    
    init(_ hawkerID: Int ,_ hawkerName: String, _ latitude: Float, _ longitude: Float, _ address: String ){
        self.hawkerID = hawkerID
        self.hawkerName = hawkerName
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }

}
