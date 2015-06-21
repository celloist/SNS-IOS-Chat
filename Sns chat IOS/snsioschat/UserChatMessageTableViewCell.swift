//
//  UserChatMessageTableViewCell.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 20-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//
import UIKit
import Foundation

class UserChatMessageTableViewCell: MessageTableViewCell {
    override func setColours() {
        super.setColours()
        view.backgroundColor = UIColor.purpleColor()
        user.text = "u"
    }
}