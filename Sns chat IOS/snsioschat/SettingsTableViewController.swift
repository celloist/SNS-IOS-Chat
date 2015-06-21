//
//  SettingsTableViewController.swift
//  Sns chat IOS
//
//  Created by User on 18/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var pincodeEnabled: UISwitch!
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    var validPin:Bool {
        return count(pincode.text!) == 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        pincode.keyboardType = .NumberPad
        pincodeEnabled.setOn((userDefaults.valueForKey("pincode_enabled") as? Bool)!, animated:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textEnterd(sender: UITextField) {
        if count(sender.text) == 5 {
            userDefaults.setInteger(sender.text.hashValue, forKey: "pincode")
        }

    }

    @IBAction func pincodeEnabled(sender: UISwitch) {
        if sender.on != userDefaults.valueForKey("pincode_enabled") as? Bool {
            if sender.on {
                if  validPin {
                    userDefaults.setBool(true, forKey: "pincode_enabled")
                    userDefaults.synchronize()
                }
                else{
                    pincodeEnabled.setOn(false, animated: true)
                }
            } else {
                userDefaults.setBool(false, forKey: "pincode_enabled")
                userDefaults.synchronize()
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
