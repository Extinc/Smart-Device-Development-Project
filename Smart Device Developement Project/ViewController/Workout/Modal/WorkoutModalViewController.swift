//
//  WorkoutModalViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 24/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
class WorkoutModalViewController: UIViewController {

    @IBOutlet weak var addBtn: MDCFloatingButton!
    
    @IBOutlet weak var modalView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.isOpaque = false
        self.showAnimate()
        LifestyleTheme.styleFloatBtn(btn: addBtn, title: "", pColor: Colors.PrimaryColor())
        
        modalView.isOpaque = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 1;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1		
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
