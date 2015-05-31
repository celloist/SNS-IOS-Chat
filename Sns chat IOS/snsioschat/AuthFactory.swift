//
//  AuthFactory.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class AuthFactory {
    class func create (type: String) -> Auth? {
        var auth:Auth?
        let ltype = type.lowercaseString
        if ltype == "basic" {
            auth = BasicAuth()
        }
        
        return auth
    }
}
