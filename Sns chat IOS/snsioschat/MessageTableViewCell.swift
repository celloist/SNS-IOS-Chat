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
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var view: UIView!
    
    func updateUI() {
        if let message = self.message {
            let formattedDate = DateText(rawDate: message.time)
            
            timestamp.text = formattedDate.getFormattedDate()
            chatMessage.textColor = UIColor.whiteColor()
            
            chatMessage.text = message.text

            setColours()
            view.layer.cornerRadius = CGFloat(6)
            view.sizeToFit()
        }
    }
    
    func setColours () {
        chatMessage.textColor = UIColor.whiteColor()
        timestamp.textColor = UIColor.whiteColor()
        user.textColor = UIColor.whiteColor()
    }
}
