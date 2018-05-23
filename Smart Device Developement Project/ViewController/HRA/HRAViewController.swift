//
//  HRAViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MapKit

<<<<<<< HEAD
class HRAViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
=======
class HRAViewController: UIViewController, UITableViewDataSource {
>>>>>>> 36e0d21b13ea8fa45b168bfe3bda0d4fc7733b9a
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label?.text = "Bryan 1 star restaurant"
        //cell.imageView?.image = UIImage(named: name)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
