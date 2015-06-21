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
    let system:Bool
    
    var sender:String {
        get {
            var concreteType = ""
            
            if isEmployee {
                concreteType = "employee"
            } else if system {
                concreteType = "system"
            } else {
                concreteType = "user"
            }
            
            return concreteType
        }
    }
    
    var messageText:String {
        get {
            if let concreteUser = user {
                return "\(concreteUser.name): \(text)"
            } else {
                return text
            }
        }
    }
    
    init(_user:User?, _text:String, _time:String, _isEmployee:Bool, _system:Bool){
        user = _user
        text = _text
        time = _time
        isEmployee = _isEmployee
        system = _system
    }
    
    
}