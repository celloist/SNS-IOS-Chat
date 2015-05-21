//
//  Message.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Message{
    let user:User?
    let time:String
    let text:String
    let isEmployee:Bool
    
    init(_user:User?,_text:String,_time:String, _isEmployee:Bool){
        if let unwrappedUser = _user {
            user = unwrappedUser
        } else {
            user = nil
        }
        text = _text
        time = _time
        isEmployee = _isEmployee
        
    }
}