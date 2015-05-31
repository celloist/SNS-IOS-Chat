//
//  RestfullAuth.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class RestfullFactory: NSObject {
    class func create (type: String) -> BasicRestFull? {
        var restfull:BasicRestFull
        
        switch type {
            case "JSON":
                restfull = Restfull()
                break;
            default:
                restfull = BasicRestFull()
        }
        
        return restfull
    }
}