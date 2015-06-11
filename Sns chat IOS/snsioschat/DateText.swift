//
//  DateText.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 18-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit
import Foundation

class DateText: NSObject {
    var components:NSDateComponents?
    
    init (rawDate: String) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        var date = dateFormatter.dateFromString(rawDate)
        let calendar = NSCalendar.currentCalendar()
        if let formattedDate = date {
            let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitHour | .CalendarUnitMinute, fromDate: formattedDate)
            self.components = components
        }
    }
    
    func getFormattedDate () -> String {
        var returnData = ""
        
        if let date = components {
            returnData = "\(date.day)-\(date.month)-\(date.year) \(date.hour):\(date.minute)"
        }
        
        return returnData
    }
}