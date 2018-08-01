//
//  ProfileViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 10/7/18.
//  Copyright © 2018 ITP3   12. All rights reserved.
//

import UIKit
import MaterialComponents
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func signOut(_ sender: Any) {
        AuthenticateUser.logout()
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cardView: MDCCard!
    	
    var lifeStyle = LifestyleTheme()
    var accInfo: AccountProfile?
    var height: Double = 0.0
    var weight: Double = 0.0
     var speed: Double = 0.0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AuthenticateUser.getHeight { (height) in
            self.height = height
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        AuthenticateUser.getWeight { (weight) in
            self.weight = weight
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        AuthenticateUser.getZombieSpeed { (speed) in
            self.speed = speed
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LifestyleTheme.styleCard(card: cardView, isInteractable: true, cornerRadius: 8)
        print(Double(cardView.cornerRadius))
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String?
        
        if section == 0 {
            header = "Account"
        } else if section == 1 {
            header = "Other"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if section == 0 {
            return 2
        } else {
            return 4
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
                cell.textLabel?.text = "Email: "
                cell.detailTextLabel?.text = AuthenticateUser.getCurrEmail()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
                cell.textLabel?.text = "Password: "
                cell.detailTextLabel?.text = "********"
                return cell
            }
        } else {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
                cell.textLabel?.text = "Height: "
                cell.detailTextLabel?.text = "\(Int(self.height)) cm"
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
                cell.textLabel?.text = "Weight: "
                cell.detailTextLabel?.text = "\(Int(self.weight)) kg"
                return cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
                cell.textLabel?.text = "Zombie Speed: "
                cell.detailTextLabel?.text = "\(Int(self.speed)) "
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "btnCell", for: indexPath) as! ProfileBtnCustomCell
                LifestyleTheme.styleBtn2(btn: cell.btn, title: "Edit", pColor: Colors.PrimaryDarkColor())
                return cell
            }

        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openEdit" {
            var vc = segue.destination as! ProfileEditViewController
            if let passedHeight:Double = self.height{
                vc.passedHeight = passedHeight
            }
            if let passedWeight:Double = self.weight{
                vc.passedWeight = passedWeight
            }
            
            if let passedzs:Double = self.speed{
                vc.passedZS = passedzs
            }
        }
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

