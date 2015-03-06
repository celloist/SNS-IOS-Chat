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
                        //Loop through all the customers
                        for rawItem in payload {
                            if let customer = rawItem as? NSDictionary{
                                //retreive and loop through all the customers chats
                                if let chats = customer["chats"] as? NSArray {
                                    for rawChat in chats {
                                        if let chatFrame = rawChat as? NSDictionary {
                                            //get all messages within a chat
                                            if let chatMessages = rawChat["chat"] as? NSArray {
                                                
                                                for rawChatMessage in chatMessages {
                                                    if let chatMessage  = rawChatMessage as? NSDictionary {
                                                        if let message = chatMessage["message"] as? String {
                                                            println(message)
                                                        }
                                                    }
                                                }
                                                
                                            } else {
                                                println("Something else")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        println("Filed")
                    }
                }
            } else {
                println("Failed to gather data")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

