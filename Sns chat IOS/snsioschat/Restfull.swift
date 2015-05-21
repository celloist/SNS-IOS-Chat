//
//  Restfull.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//
import Foundation

class RestFull {
    var asynch = true
    
    func getData (url : String, callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        getData(url, params: [String:AnyObject](), callback: callback)
    }
    
    func getData (url : String, params: [String:AnyObject], callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        send("GET", url: url, params: params, callback: callback)
    }
    
    func postData (url: String, params: [String:AnyObject], callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        send("POST", url: url, params: params, callback: callback)
    }
    
    func putData (url: String, params: [String:AnyObject], callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        send("PUT", url: url, params: params, callback: callback)
    }
    
    func deleteData (url: String, params: [String:AnyObject], callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        send("DELETE", url: url, params: params, callback: callback)
    }
    
    func send (method: String, url: String, params: AnyObject, callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var err: NSError?
        request.HTTPMethod = method
        //println("params = \(params)")
        if params.count > 0 {
            //println("heyo")
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
            //println(request.HTTPBody)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if asynch {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                if ((error) != nil) {
                    callback(success: false, data : ["error" : error])
                } else {
                    var returnData:[String:AnyObject] = ["response" : response]
                    
                    var jsonError: NSError?
                    if let result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as? NSDictionary {
                        
                        returnData["result"] = result
                        callback(success: true, data : returnData)
                    } else {
                        callback(success: false, data : returnData)
                    }
                }
            }
        }
    }
}
