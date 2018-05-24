//
//  MoodTableController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 24/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MoodTableController: UIViewController, UITableViewDataSource	 {
    let data:[[String]] = [["Happy"],["confused"],["surprise"]]
    
    let headers:[String] = ["5/1/2017","5/2/2017","5/3/2017"]
    
    let img:[[String]] = [["happy"],["confused"],["surprised"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)-> Int{
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: img[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
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
