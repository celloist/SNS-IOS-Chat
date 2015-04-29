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

        
        if let Username: String = userDefaults.valueForKey("username") as? String{
            if let Id : String = userDefaults.valueForKey("id") as? String{
                customer = Customer(_name: Username, _id: Id);
                
                let vc : MenuViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
            
                vc.customer = self.customer
            
            
                self.showViewController(vc as MenuViewController, sender: vc)

            }
        }
        /*
        
        chatModel.getData(BaseRequest.concat("customers")) {(success, data) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    if let result = data["result"] as? NSDictionary {
                        var customers = self.customerFactory.createCustomersFromJson(result["data"]!);
                        
                        if customers.count > 0 {
                            self.customer = customers[0]
                            self.label.text = self.customer?.name
                        } else {
                            //There are no customers yet !!!!
                            //Small hack: Create a customer
                            var params = [String:String]()
                            params["name"] = "Koos van Duren"
                            params["registrationId"] = "1tester1"
                        
                            self.chatModel.postData(BaseRequest.concat("customers"), params: params)  {(success, data) in
                                if success {
                                    if let result = data["result"] as? NSDictionary {
                                        let customer = self.customerFactory.createCustomerFromJson(result["data"]!)
                                        
                                        self.customer = customer
                                        self.label.text = self.customer?.name

                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    */
        
    }
    
    @IBAction func ButtonOnPressed(sender: UIButton) {
        
        
        var params = [String:String]()
        params["name"] = Username.text;
        var userDefaults = NSUserDefaults.standardUserDefaults()

       
        userDefaults.setValue(Username.text, forKey: "username")
        
        
        if let deviceToken: String = userDefaults.valueForKey("deviceToken") as? String  {
             params["registrationId"] = deviceToken
            params["OS"] = "IOS"
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
                }
            }
        }
        userDefaults.synchronize()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! MenuViewController
        dest.customer = self.customer
    }
}

