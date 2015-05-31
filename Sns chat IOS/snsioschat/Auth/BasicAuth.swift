//
//  BasicAuth.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class BasicAuth: NSObject, Auth {
    var username = ""
    var password = ""
    var headers = [String:String]()
    
    func setSettings (settings: [String:String]) {
        if let username = settings["username"],
            let password = settings["password"] {
            self.username = username
            self.password = password
        }
    }
    
    func getHeaders () -> [String:String] {
        
        if headers.isEmpty {
            let rawcredentials = "\(username):\(password)"
            let utf8credentials = rawcredentials.dataUsingEncoding(NSUTF8StringEncoding)
            
            if let base64Encoded = utf8credentials?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)) {
                headers["Authorization"] = "Basic \(base64Encoded)"
            }
        }
        
        return headers
    }
}
