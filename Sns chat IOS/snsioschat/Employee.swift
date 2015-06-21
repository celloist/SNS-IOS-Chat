//
//  Employee.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 18-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class Employee: User {
    init(_name:String, _id:String){
        super.init(id:_id,name:_name)
    }
}
