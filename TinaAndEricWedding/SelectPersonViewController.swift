//
//  SelectPersonViewController.swift
//  ParseStarterProject
//
//  Created by tina on 6/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class SelectPersonViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var namesToSelect: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("select person view controller names are \(namesToSelect)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(namesToSelect!)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = namesToSelect![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name: String = namesToSelect![indexPath.row]
        let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.mySetObject(name, forKey:kSecValueData)
        keychainWrapper.writeToKeychain()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
        NSUserDefaults.standardUserDefaults().synchronize()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var tabController = mainStoryboard.instantiateViewControllerWithIdentifier("tab") as! UITabBarController
        UIApplication.sharedApplication().keyWindow!.rootViewController = tabController;
    }
}
