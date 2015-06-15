//
//  LoginViewController.swift
//  TinaAndEricWedding
//
//  Created by tina on 6/13/15.
//  Copyright (c) 2015 tina. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let MAX_CHAR_COUNT = 6
    var hasCheckedCred = false

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !hasCheckedCred {
            hasCheckedCred = true
            if let hasLoggedIn = NSUserDefaults.standardUserDefaults().valueForKey("hasLoginKey") as? Bool {
                if hasLoggedIn {
                    let keychainWrapper = KeychainItemWrapper(identifier: "username", accessGroup: nil)
                    let name = keychainWrapper.objectForKey(kSecValueData) as? String
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var tabController = mainStoryboard.instantiateViewControllerWithIdentifier("tab") as! UITabBarController
                    UIApplication.sharedApplication().keyWindow!.rootViewController = tabController;
                }
            }
        }
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text!) + count(string) - range.length
        loginButton!.enabled = newLength >= MAX_CHAR_COUNT
        let shouldUpdate = newLength <= MAX_CHAR_COUNT
        if shouldUpdate {
            let lowercaseCharRange: NSRange = (string as NSString).rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet())
            
            if (lowercaseCharRange.location != NSNotFound) {
                textField.text = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
                return false;
            }
            return true
        }
        return false
    }
    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        let query = PFQuery(className: "csv")
        query.whereKey("token", equalTo: textField.text)
        query.selectKeys(["name"])
        query.findObjectsInBackgroundWithBlock { (people, error) -> Void in
            if (error == nil) {
                var names: [String] = []
                let peeps = people as! [PFObject]
                if count(peeps) > 0 {
                    for person in peeps {
                        let name = person.objectForKey("name") as! String
                        print("name is \(name)")
                        names.append(name)
                    }
                } else {
                    // display code invalid
                    var alert = UIAlertController(title: "Your code is invalid", message: "Please check your email for the correct code", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }

                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var navController = mainStoryboard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
                UIApplication.sharedApplication().keyWindow!.rootViewController = navController;
                if let selectPeopleViewController = navController.topViewController as? SelectPersonViewController {
                    selectPeopleViewController.namesToSelect = names
                }
            } else {
                println("Error in retrieving \(error)")
                var alert = UIAlertController(title: "Error retrieving info", message: "Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
