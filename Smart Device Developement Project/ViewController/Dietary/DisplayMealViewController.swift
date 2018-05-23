//
//  DisplayMealViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 22/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DisplayMealViewController: UIViewController {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameTextField: UITextField!
    
    var mealItem: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mealNameTextField.text = mealItem?.mealName
        mealImage.image = UIImage(named: mealItem!.imagePath)
        
        self.navigationItem.title = mealItem?.mealName
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
