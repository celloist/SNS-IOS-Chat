//
//  chat.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Chat : RestFull {
    let id:String
    //   let category:String
    let customer:Customer
    let category:Category
    //  let employees:[Employees]; TODO
    var messages = [Message]()
    
    init(id:String, customer: Customer, category : Category){
        self.id = id
        self.customer = customer
        self.category = category
    }

    func appendMessages (messages: [Message]) {
        for message in messages {
            self.messages.append(message)
        }
    }
    
    func appendMessage (message: Message) {
        self.messages.append(message)
    }
}