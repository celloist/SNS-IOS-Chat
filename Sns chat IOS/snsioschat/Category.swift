//
//  Category.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Category {
     let id:String
     let name:String
    
    var data:Dictionary<String, String> {
        return [
            "id" : id,
            "name" : name
        ]
    }
    
    init (id: String, name : String) {
        self.id = id
        self.name = name
    }
 
}
