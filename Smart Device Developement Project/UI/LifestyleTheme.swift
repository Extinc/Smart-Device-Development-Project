//
//  LifestyleTheme.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 25/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class LifestyleTheme: NSObject {
    let colors:Colors
    
    override init() {
        colors = Colors()
    }
    
    func styleBtn(btn: MDCFlatButton, title: String, pColor: UIColor){
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: btn)
        let btncolorScheme = MDCSemanticColorScheme()
        btncolorScheme.primaryColor = pColor
        btn.setTitle(title, for: UIControlState())
        MDCButtonColorThemer.applySemanticColorScheme(btncolorScheme, to: btn)
        btn.titleLabel?.textColor = colors.secondaryTextColor
    }
    
}