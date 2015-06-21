//
//  ChatTableViewCell.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 21-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    var chat:Chat? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lastMessageTimestamp: UILabel!
    @IBOutlet weak var currentEmployee: UILabel!
    
    func updateUI() {
        if let chatItem = chat {
            title.text = chatItem.subject
            
            if let currentEmployeeItem = chatItem.currentEmployee {
                currentEmployee.text = "\(currentEmployeeItem.name)"
            } else {
                currentEmployee.text = "nog geen medewerker toegewezen"
            }
            
            let formattedDate = DateText(rawDate: chatItem.lastUpdate)
            
            lastMessageTimestamp.text = formattedDate.getFormattedDate()
        }
    }

}
