//
//  ServiceLocator.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 13-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class ServiceLocator: NSObject {
    class var sharedInstance: ServiceLocator {
        struct Static {
            static let instance: ServiceLocator = ServiceLocator()
        }
        return Static.instance
    }

    private var services = [String:AnyObject]()
    
    func registerService (name: String, service: AnyObject) {
        let key = name
        
        services[key] = service
    }
    
    func unregisterServive (name:String) -> Bool {
        if let removed: AnyObject = services.removeValueForKey(name) {
            return true
        }
        
        return false
    }
    
    func getService (name: String) -> AnyObject? {
        let key = name
        if let servive:AnyObject = services[key] {
            return servive
        }
        
        return nil
    }
}