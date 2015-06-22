//
//  CustomerFactory.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class EmployeeFactory: NSObject {
    class func createEmployeesFromJson (data:AnyObject) -> [Employee] {
        var employees = [Employee]()
        
        if let payload  = data as? NSArray {
            //Loop through all the customers
            for rawItem in payload {
                if let employee = EmployeeFactory.createEmployeeFromJson(rawItem) {
                    employees.append(employee)
                }
            }
        }
        
        return employees
    }

    
    class func createEmployeeFromJson (data:AnyObject) -> Employee? {
        var newEmployee:Employee?
        
        if let employee = data as? NSDictionary {
            if let name = employee["username"] as? String, let id = employee["_id"] as? String {
                newEmployee = Employee(_name:name,_id:id)
            }
        }
        
        return newEmployee
    }
}
