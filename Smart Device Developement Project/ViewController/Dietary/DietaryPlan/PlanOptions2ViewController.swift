//
//  PlanOptions2ViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 25/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class PlanOptions2ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData = [String]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlanOptions2TableViewCell
        cell.optionsLabel.text = tableData[indexPath.section]
        return cell
    }
    
    
    
    

    
    // MARK: - Navigation

 
}
