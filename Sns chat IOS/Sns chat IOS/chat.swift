//
//  chat.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Chat : MainModel{
    //   let category:String
    let customer:Customer
    //  let employees:[Employees]; TODO
    var messages:[Message]
    
    init(id:String
        //,_category:String
        ,_customer:Customer
        //,_employees:[Employees]
        ,_messages:[Message]
        ){
            customer = _customer;
            messages = _messages;
            //category = _category;
            super.init(_id:id);
    }
    
    
}