//
//  ThemeUIButton.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 01-05-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ThemeUIButton: UIButton {
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.backgroundColor = Styles.DefaultTheme["backgroundColour"]
        self.tintColor = Styles.DefaultTheme["textColour"]
        setCustomPadding()
    }
    
    func setCustomPadding () {
        let padding = CGFloat(6.0)
        self.titleEdgeInsets = UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIButton {
    
    public override func intrinsicContentSize() -> CGSize {
        
        let intrinsicContentSize = super.intrinsicContentSize()
        
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        
        return CGSize(width: adjustedWidth, height: adjustedHeight)
        
    }
    
}