//
//  utils.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 19-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

func createUiColour (data: NSDictionary) -> UIColor? {
    var returnValue:UIColor?
    
    if let red = data["r"] as? CGFloat, let green = data["g"] as? CGFloat, let blue = data["b"] as? CGFloat {
        returnValue = UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: 1)
    }
    
    return returnValue
}

func encodePin (pin:String) {
    
}