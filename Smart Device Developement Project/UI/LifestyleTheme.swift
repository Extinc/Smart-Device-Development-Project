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
        btn.titleLabel?.textColor = colors.primaryTextColor
    }
    
    static func styleBtn2(btn: MDCFlatButton, title: String, pColor: UIColor){
        let color = Colors()
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: btn)
        let btncolorScheme = MDCSemanticColorScheme()
        btncolorScheme.primaryColor = pColor
        btn.setTitle(title, for: UIControlState())
        MDCButtonColorThemer.applySemanticColorScheme(btncolorScheme, to: btn)
        btn.titleLabel?.textColor = color.primaryTextColor
    }
    
    static func styleFloatBtn(btn: MDCFloatingButton, title: String, pColor: UIColor){
        let color = Colors()
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: btn)
        let btncolorScheme = MDCSemanticColorScheme()
        btncolorScheme.primaryColor = pColor
        btn.setTitle(title, for: UIControlState())
        MDCButtonColorThemer.applySemanticColorScheme(btncolorScheme, to: btn)
        btn.backgroundColor = color.primaryColor
    }
    
    
    static func styleCard(card: MDCCard, isInteractable: Bool, cornerRadius: Double?){
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.surfaceColor = .white
        card.backgroundColor = .gray
        card.isUserInteractionEnabled = isInteractable
        card.setBorderColor(UIColor.blue, for: card.state)
        if cornerRadius != nil {
            card.cornerRadius = CGFloat(cornerRadius!)
        }
        
        MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: card)
    }
    
    
    func styleTextFieldOutlined(textField: MDCTextField){
        
    }
}
