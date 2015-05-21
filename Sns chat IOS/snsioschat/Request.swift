//
//  Request.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

public struct BaseRequest {
    static var BASE_URI = "http://snsauthentication.herokuapp.com/"
    //static let BASE_URI = "https://quiet-ocean-2107.herokuapp.com/"
    
    public static func concat (part: String) -> String  {
        return BASE_URI + part
    }
}