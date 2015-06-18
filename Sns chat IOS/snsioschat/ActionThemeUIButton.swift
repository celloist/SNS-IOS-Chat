//
//  ActionThemeUIButton.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 11-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class ActionThemeUIButton: ThemeUIButton {
    override func setCustomColour() {
        self.backgroundColor = Styles.ActionTheme["backgroundColour"]
        self.tintColor = Styles.ActionTheme["textColour"]
    }
}