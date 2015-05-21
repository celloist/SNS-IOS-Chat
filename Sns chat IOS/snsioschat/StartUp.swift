//
//  StartUp.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class StartUp: NSObject {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func setupUser () {
        if let userID = defaults.stringForKey("userID") {
            
        }
    }
}
