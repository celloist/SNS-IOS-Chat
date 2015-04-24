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
    
    @IBOutlet weak var label: UILabel!
    private var customer: Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ChatsController
        dest.customer = self.customer
    }
}

