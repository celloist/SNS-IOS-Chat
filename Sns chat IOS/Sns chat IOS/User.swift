//
//  User.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class User: MainModel{
    
    let name:String
    
    init(_id:String,_name:String){
        name = _name
        
        
        
        super.init(_id:_id);
    }
    
}