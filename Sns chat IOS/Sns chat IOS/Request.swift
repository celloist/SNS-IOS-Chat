//
//  Request.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

public struct BaseRequest {
    static let BASE_URI = "http://snsauthentication.herokuapp.com/"
    //static let BASE_URI = "https://quiet-ocean-2107.herokuapp.com/"
    
    public static func concat (part: String) -> String  {
        return BASE_URI + part
    }
}

class Request{
    private let chatModel  = RestFull()
    
    func getCustomers(data:[String:AnyObject]) -> [Customer]
    {
        var customers = [Customer]()
        
        if let result = data["result"] as? NSDictionary
        {
            if let payload  = result["data"] as? NSArray
            {
                
                //Loop through all the customers
                for rawItem in payload
                {
                    if let customer = rawItem as? NSDictionary{
                        
                        if let name = customer["name"] as? String
                        {
                            if let id = customer["_id"] as? String
                            {
                                customers.append(Customer(_name:name,_id:id))
                            }
                        }
                    }
                }
            }
        }
        
        return customers;
    }
}