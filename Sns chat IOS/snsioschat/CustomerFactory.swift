//
//  CustomerFactory.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class CustomerFactory: NSObject {
    func createCustomersFromJson (data:AnyObject) -> [Customer] {
        var customers = [Customer]()
                    
        if let payload  = data as? NSArray {
            //Loop through all the customers
            for rawItem in payload {
                if let customer = createCustomerFromJson(rawItem) {
                    customers.append(customer)
                }
            }
        }
        
        return customers
    }
    
    func createCustomerFromJson (data:AnyObject) -> Customer? {
        var newCustomer:Customer?
        
        if let customer = data as? NSDictionary {
            if let name = customer["name"] as? String {
                if let id = customer["_id"] as? String {
                    newCustomer = Customer(_name:name,_id:id)
                }
            }
        }
        
        return newCustomer
    }
}
