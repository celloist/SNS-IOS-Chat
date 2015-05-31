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
    private var chatModel:RestFull?
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var MainButton: UIButton!
    @IBOutlet weak var label: UILabel!
    private var customer: Customer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customer = ServiceLocator.sharedInstance.getService("customer") as? Customer {
            segue()
        }
        
        chatModel = ServiceLocator.sharedInstance.createFactoryService("RestFull") as? RestFull
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
        self.chatModel?.postData(BaseRequest.concat("customers"), params: params)  {(success, data) in
            if success {
                if let result = data["result"] as? NSDictionary {
                    let customer = self.customerFactory.createCustomerFromJson(result["data"]!)
                    
                    self.customer = customer
                    userDefaults.setValue(customer?.id, forKey: "id")
                    userDefaults.synchronize()
                    
                    
                    ServiceLocator.sharedInstance.registerService("customer", service: self.customer!)
                    self.segue()

                }
            }
        }
        userDefaults.synchronize()
        
    }
    
    func segue () {
        let vc : MenuViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
        self.showViewController(vc as MenuViewController, sender: vc)
    }
}

