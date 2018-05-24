//
//  SummaryViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 24/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    let colors = Colors()
    
    let details = [Details("Goal", "Lose Weight"),
                   Details("Height", "170cm"),
                   Details("Weight", "50kg"),
                   Details("Lifestyle", "Exercise 1-3 days a week")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return details.count
    }
    
    //return a UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        cell.thingLabel.text = details[indexPath.row].thing
        cell.actualThingLabel.text = details[indexPath.row].actualThing
        return cell
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
    }
    */

}
