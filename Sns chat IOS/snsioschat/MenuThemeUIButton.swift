//
//  LargeThemeUIButton.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 12-05-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class MenuThemeUIButton: ThemeUIButton {
    override func setCustomPadding () {
        let topBottomPadding = CGFloat(29.0)
        let leftRightPadding = CGFloat(12.0)
        
        self.titleEdgeInsets = UIEdgeInsetsMake(topBottomPadding, leftRightPadding, topBottomPadding, leftRightPadding)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
