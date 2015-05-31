//
//  Config.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class Config {
    private var values = [String:AnyObject]()
    
    func setValue (key:String, value:AnyObject, override:Bool) {
        var setValue = true
        
        if valueSet(key) && !override {
            setValue = false
        }
        
        if setValue {
            values[key] = value
        }
    }
    
    func setValue (key:String, value:AnyObject) {
        setValue(key, value: value, override: true)
    }
    
    func getValue (key: String) -> AnyObject? {
        if valueSet(key) {
            return values["\(key)"]
        }
        
        return nil
    }
    
    private func valueSet (key:String) -> Bool {
        return values.indexForKey(key) != nil
    }
}
