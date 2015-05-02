//
//  ThemeUINavigationViewController.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 27-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

public class ThemeUINavigationViewController: UINavigationController {
    public struct DefaultStyle {
        static var BackgroundColour = UIColor.whiteColor()
        static var StatusBar = UIStatusBarStyle.LightContent
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return DefaultStyle.StatusBar
    }
}
