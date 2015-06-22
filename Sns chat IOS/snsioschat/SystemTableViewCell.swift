//
//  SystemTableViewCell.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 20-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class SystemTableViewCell: MessageTableViewCell {
    override func setColours() {
        super.setColours()
        user.text = "System"
        if let colour = createUiColour(["r" : 95, "g" : 204, "b": 247]) {
            view.backgroundColor = colour
        } else {
            view.backgroundColor = UIColor.blueColor()
        }
    }
}