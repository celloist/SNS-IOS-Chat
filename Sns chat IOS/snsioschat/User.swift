//
//  User.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class User {
    let id:String
    let name:String
    
    init(id:String, name:String){
        self.name = name
        self.id = id
    }
}