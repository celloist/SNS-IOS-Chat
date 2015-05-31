//
//  RestFull.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 31-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class RestFull: BasicRestFull {
    override init() {
        super.init()
        
        addHeader("Content-Type", value: "application/json")
        addHeader("Accept", value: "application/json")
    }
    override func setBody (request: NSMutableURLRequest, params: AnyObject) {
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
    }
    
    override func parseResult (data: NSData!) -> AnyObject? {
        var jsonError: NSError?
        var returnData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as? NSDictionary
        
        return returnData
    }
}
