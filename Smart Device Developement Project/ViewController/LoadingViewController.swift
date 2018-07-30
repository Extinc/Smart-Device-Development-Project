//
//  LoadingViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 30/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.PrimaryColor()

        LoadingData.shared.loadData(){
            done in
            
            print(LoadingData.shared.rcalories)
            if done == true{
                self.performSegue(withIdentifier: "loginOK", sender: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
        segue.destinationViewContrloadedData
    }
    */

}
