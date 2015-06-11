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
            let formattedDate = DateText(rawDate: message.time)
            
            timestamp.text = formattedDate.getFormattedDate()
            chatMessage.textColor = UIColor.whiteColor()
            
            if message.isEmployee {
                view.backgroundColor = UIColor.blueColor()
            } else if message.system  {
                view.backgroundColor = UIColor.grayColor()
            } else {
                view.backgroundColor = UIColor.yellowColor()
            }
            
            chatMessage.text = message.text
            
            view.layer.cornerRadius = CGFloat(10)
            view.sizeToFit()
        }
    }
}
