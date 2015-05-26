//
//  ViewController.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    private let customerFactory  = CustomerFactory()
    private let chatModel = RestFull()
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var MainButton: UIButton!
    @IBOutlet weak var label: UILabel!
    private var customer: Customer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        
        if let Username: String = userDefaults.valueForKey("username") as? String, let Id : String = userDefaults.valueForKey("id") as? String{
            
            self.customer = Customer(_name: Username, _id: Id)
            self.segue()
        }
    }
    
    @IBAction func ButtonOnPressed(sender: UIButton) {
        var params = [String:String]()
        params["name"] = Username.text;
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        
        userDefaults.setValue(Username.text, forKey: "username")
        
        
        if let deviceToken: String = userDefaults.valueForKey("deviceToken") as? String  {
            params["registrationId"] = deviceToken
            params["os"] = "IOS"
        }
        else {
            // no device Token
            params["registrationId"] = "NoDeviceToken"
            
        }
        self.chatModel.postData(BaseRequest.concat("customers"), params: params)  {(success, data) in
            if success {
                if let result = data["result"] as? NSDictionary {
                    let customer = self.customerFactory.createCustomerFromJson(result["data"]!)
                    
                    self.customer = customer
                    userDefaults.setValue(customer?.id, forKey: "id")
                    userDefaults.synchronize()
                    self.segue()

                }
            }
        }
        userDefaults.synchronize()
        
    }
    
    func segue () {
        ServiceLocator.sharedInstance.registerService("customer", service: self.customer!)
        
        let vc : MenuViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
        self.showViewController(vc as MenuViewController, sender: vc)
    }
}

