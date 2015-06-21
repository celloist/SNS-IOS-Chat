//
//  SettingsTableViewController.swift
//  Sns chat IOS
//
//  Created by User on 18/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var pincodeEnabled: UISwitch!
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    var validPin:Bool {
        return count(pincode.text!) == 5
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        pincode.delegate = self
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

    @IBAction func pincodeEnabled(sender: UISwitch) {
        if sender.on != userDefaults.valueForKey("pincode_enabled") as? Bool {
            if sender.on {
                if  validPin {
                    userDefaults.setInteger(pincode.text.hashValue, forKey: "pincode")
                    userDefaults.setBool(true, forKey: "pincode_enabled")
                    JLToast.makeText("Pincode opgeslagen").show()
                    userDefaults.synchronize()
                } else {
                    pincodeEnabled.on = false
                    JLToast.makeText("Voer eerst een vijfcijferige pincode in!").show()
                    pincodeEnabled.setOn(false, animated: false)
                }
            } else {
                JLToast.makeText("Pincode uitgeschakeld!").show()
                userDefaults.setBool(false, forKey: "pincode_enabled")
                userDefaults.setInteger(0, forKey: "pincode")
                userDefaults.synchronize()
                
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool
    {
        if textField == pincode {
            let maxLength = 5
            let currentString: NSString = textField.text
            let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
            
            return newString.length <= maxLength
        }
        
        return true
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
