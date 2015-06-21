//
//  EmployeeTableViewCell.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 20-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: MessageTableViewCell {
    override func setColours() {
        super.setColours()
        user.text = "onbekend"
        if let concreteMessage = message {
            if let employee = concreteMessage.user {
                user.text = employee.name
            }
        }
        
        view.backgroundColor = UIColor.greenColor()
    }
}
