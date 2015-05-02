//
//  AppDelegate.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 02-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Read the main config file
        if let path = NSBundle.mainBundle().pathForResource("mainconfig", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) {
                
                func createUiColourFromConfig (data: NSDictionary) -> UIColor? {
                    var returnValue:UIColor?
                    
                    if let red = data["r"] as? CGFloat, let green = data["g"] as? CGFloat, let blue = data["b"] as? CGFloat {
                        returnValue = UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: 1)
                    }
                    
                    return returnValue
                }
                //Extract some key config settings
                if let nav = config["NAVIGATION_BAR"] as? NSDictionary, let button = config["BUTTON"] as? NSDictionary, let apiUrl = config["API_URL"] as? String {
                    //Navigation props
                    if let navBackground = nav["BACKGROUND"] as? NSDictionary, let navText = nav["TEXT_COLOUR"] as? NSDictionary, let navBarStyle = nav["THEME"] as? Int {
                        
                        //Navigation background
                        if let navBackgroundColour = createUiColourFromConfig(navBackground) {
                            UINavigationBar.appearance().barTintColor = navBackgroundColour
                        }
                        //Navigation text colour
                        if let navTextColour = createUiColourFromConfig(navText) {
                            UINavigationBar.appearance().tintColor = navTextColour
                            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : navTextColour]
                        }
                        //Barstyles
                        let barStyles:[Int:UIStatusBarStyle] = [
                            0 : UIStatusBarStyle.Default,
                            1 : UIStatusBarStyle.LightContent
                        ]
                        
                        if navBarStyle >= 0 && navBarStyle <= barStyles.count {
                            ThemeUINavigationViewController.DefaultStyle.StatusBar = barStyles[navBarStyle]!
                        }
                        
                    }
                    //Button props
                    if let buttonBackground = button["BACKGROUND"] as? NSDictionary, let buttonText = button["TEXT_COLOUR"] as? NSDictionary {
                        //Default button style
                        if let buttonBackgroundStyle = createUiColourFromConfig(buttonBackground) {
                            ThemeUIButton.DefaultStyle.BackgroundColor = buttonBackgroundStyle
                        }

                        //Default button style
                        if let buttonTextColour = createUiColourFromConfig(buttonText) {
                            ThemeUIButton.DefaultStyle.TextColor = buttonTextColour
                        }
                    }
                    //The base api request url, used in every restfull request to the api
                    BaseRequest.BASE_URI = apiUrl
                }

            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

