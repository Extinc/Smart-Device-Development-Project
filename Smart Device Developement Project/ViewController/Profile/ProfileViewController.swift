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
    

    @IBOutlet weak var editProfileBtn: MDCFlatButton!
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var profileTableView: UITableView!
    
    var lifeStyle = LifestyleTheme()
    var accInfo: AccountProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LifestyleTheme.styleCard(card: cardView, isInteractable: false, cornerRadius: 8)
        print(Double(cardView.cornerRadius))
        lifeStyle.styleBtn(btn: editProfileBtn, title: "Edit", pColor: lifeStyle.colors.secondaryDarkColor)
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
            count = 2
        } else if section == 1 {
            count = 2
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccCell", for: indexPath)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Email: "
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Password: "
            }
            cell.detailTextLabel?.text = accInfo?.emailNpw[indexPath.row]
        }
        // Incomplete below is for other
        
        return cell
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
