//
//  ThemeUIButton.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 01-05-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ThemeUIButton: UIButton {
    struct DefaultStyle {
        static var BackgroundColor = UIColor.whiteColor()
        static var TextColor = UIColor.blackColor()
    }

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.backgroundColor = DefaultStyle.BackgroundColor
        self.tintColor = DefaultStyle.TextColor
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
