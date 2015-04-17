//
//  ViewController.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let request  = Request()
    private let chatModel = RestFull()
    
    @IBOutlet weak var label: UILabel!
    private var customer: Customer?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatModel.getData("https://quiet-ocean-2107.herokuapp.com/customers", callback: {(success : Bool, data: [String:AnyObject]) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    self.customer = self.request.getCustomers(data)[1];
                    self.label.text = self.customer?.name;
                }
            }
        });
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        var dest : ChatsController = segue.destinationViewController as ChatsController
        dest.customer = self.customer
    }
}

