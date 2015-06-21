//
//  chat.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Chat {
    let id:String
    //   let category:String
    let customer:Customer
    let category:Category
    let lastUpdate:String
    var employees = [Employee]()
    var currentEmployee:Employee? {
        if employees.count > 0 {
            return employees.last
        }
        
        return nil
    }
    var messages = [Message]()
    var subject: String {
        if messages.count >= 1 {
            return messages[1].text
        }
        
        return ""
    }
    
    init(id:String, customer: Customer, category : Category, employees: [Employee], lastUpdate: String){
        self.id = id
        self.customer = customer
        self.category = category
        self.employees = employees
        self.lastUpdate = lastUpdate
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