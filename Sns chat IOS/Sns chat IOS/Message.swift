//
//  Message.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Message{
    let user:User?;
    let time:String;
    let text:String;
    
    init(_user:User?,_text:String,_time:String){
        user = _user?;
        text = _text;
        time = _time;
        
    }
    
}