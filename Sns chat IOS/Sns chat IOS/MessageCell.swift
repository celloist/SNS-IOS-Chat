//
//  MessageCell.swift
//  Sns chat IOS
//
//  Created by User on 11/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
  
    @IBOutlet var timeStamp: UILabel!
   
    @IBOutlet var message: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }
       

}
