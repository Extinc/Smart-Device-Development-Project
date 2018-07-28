//
//  Colors.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 19/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class Colors: NSObject {
    let primaryColor = UIColor(red: 0.98, green: 0.42, blue: 0.41, alpha: 1.0);
    let primaryLightColor = UIColor(red: 1.00, green: 0.61, blue: 0.59, alpha: 1.0);
    let primaryDarkColor = UIColor(red: 0.76, green: 0.22, blue: 0.24, alpha: 1.0);
    let primaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0);
    
    static func PrimaryColor()->UIColor{
        let color = Colors()
        return color.primaryColor
    }
    
    static func PrimaryLightColor()->UIColor{
        let color = Colors()
        return color.primaryLightColor
    }
    
    static func PrimaryDarkColor()->UIColor{
        let color = Colors()
        return color.primaryDarkColor
    }
    
    static func PrimaryTextColor()->UIColor{
        let color = Colors()
        return color.primaryTextColor
    }
    
//    static func SecondaryColor()->UIColor{
//        let color = Colors()
//        return color.secondaryColor
//    }
//    
//    static func SecondaryLightColor()->UIColor{
//        let color = Colors()
//        return color.secondaryLightColor
//    }
//    
//    static func SecondaryDarkColor()->UIColor{
//        let color = Colors()
//        return color.secondaryDarkColor
//    }
//    
//    static func SecondaryTextColor()->UIColor{
//        let color = Colors()
//        return color.secondaryTextColor
//    }
}
