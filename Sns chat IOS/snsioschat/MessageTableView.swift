//
//  MessageTableViewCell.swift
//  SNS tester
//
//  Created by Mark Jan Kamminga on 19-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    var message: String? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    func updateUI() {
        if let message = self.message {
            chatMessage.text = message
            chatMessage.backgroundColor = UIColor.cyanColor()
        }
    }
}
