//
//  Restfull.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//
import Foundation

class BasicRestFull {
    var asynch = true
    var headers = [String:String]()
        
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
    
    func addHeader (name: String, value: String) {
        headers[name] = value
    }
    
    func addHeaders (headers: [String:String]) {
        for (name, value) in headers {
            addHeader(name, value: value)
        }
    }
    
    func setAuthentication (auth: Auth) {
        var headers = auth.getHeaders()
        
        if headers.count > 0 {
            for (name, value) in headers {
                addHeader(name, value: value)
            }
        }
    }
    
    func removeHeader (header: String) {
        //todo unset header
    }
    
    func send (method: String, url: String, params: AnyObject, callback: (success : Bool, data: [String:AnyObject]) -> ()) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method
        //Add the headers set for this request
        if headers.count > 0 {
            for (name, value) in headers {
                request.addValue(value, forHTTPHeaderField: name)
            }
        }
        //if any params are sent, set the defined bodytype
        if params.count > 0 {
            //println("heyo")
            setBody(request, params: params)
            //println(request.HTTPBody)
        }
        
        if asynch {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                //An error has occured whilst performing the request
                if ((error) != nil) {
                    callback(success: false, data : ["error" : error])
                } else {
                    var returnData:[String:AnyObject] = ["response" : response]
                    //if succesfull in parsing the result, Return the result
                    if let result = self.parseResult(data) as? NSDictionary {
                        returnData["result"] = result
                        callback(success: true, data : returnData)
                    } else {
                        callback(success: false, data : returnData)
                    }
                }
            }
        }
    }
    
    func setBody (request: NSMutableURLRequest, params: AnyObject) {
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
    }
    
    func parseResult (data: NSData!) -> AnyObject? {
        var jsonError: NSError?
        var returnData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as? NSDictionary
        
        return returnData
    }
}
