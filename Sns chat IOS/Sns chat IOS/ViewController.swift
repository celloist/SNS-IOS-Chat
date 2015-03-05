//
//  ViewController.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let chatModel  = RestFull()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatModel.getData("https://frozen-inlet-5594.herokuapp.com/customers", callback: {(success : Bool, data: [String:AnyObject]) in
            
            if success {
                if let result = data["result"] as? NSDictionary {
                    if let payload  = result["data"] as? NSArray {
                        
                        println(payload)
                    } else {
                        println("Filed")
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

