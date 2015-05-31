//
//  Auth.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

protocol Auth {
    func getHeaders () -> [String:String]
    func setSettings([String:String])
}
