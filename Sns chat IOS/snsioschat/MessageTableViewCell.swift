//
//  MessageTableViewCell.swift
//  SNS tester
//
//  Created by Mark Jan Kamminga on 19-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit
import Foundation

class MessageTableViewCell: UITableViewCell {
    var message: Message? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    func updateUI() {
        if let message = self.message {
            /*var dateString = message.time
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            var hour = {() -> Date in
                components
            }
            let components = calendar.components(.CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
            let hour = components.hour
            let minutes = components.minute
            
            var dateThen = dateFormatter.dateFromString(dateString)
            println(dateThen)
            
            timestamp.text = message.time
            if message.isEmployee {
                view.backgroundColor = UIColor.blueColor()
            } else {
                view.backgroundColor = UIColor.orangeColor()
            }
            */
            chatMessage.text = message.text
            chatMessage.textColor = UIColor.whiteColor()
            view.layer.cornerRadius = CGFloat(10)
            view.sizeToFit()
        }
    }
}
