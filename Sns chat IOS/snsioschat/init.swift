//
//  configParser.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-06-15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation
import UIKit

func parseColoursConfig (coloursConfig: NSDictionary) -> [String:UIColor] {
    //Colour creator
    var colours = [String:UIColor]()
    //parse the colours config
    for (name, rgb) in coloursConfig {
        if let colourName = name as? String,
            let colourCodes = rgb as? NSDictionary {
                
                if let colour = createUiColour(colourCodes) {
                    colours[colourName] = colour
                }
        }
    }
    
    colours["DEFAULTS_WHITE"] = UIColor.whiteColor()
    colours["DEFAULTS_BLACK"] = UIColor.blackColor()
    
    return colours
}

func setup () {
    //Register current user to the shared instance object
    registerCurrentUser()

    //Read the main config file
    if let mainConfigPath = NSBundle.mainBundle().pathForResource("mainconfig", ofType: "plist"),
        let coloursConfigPath = NSBundle.mainBundle().pathForResource("colours", ofType: "plist") {
            
            if let config = NSDictionary(contentsOfFile: mainConfigPath),
                let coloursConfig = NSDictionary(contentsOfFile: coloursConfigPath) {
                    
                    let parsedColoursConfig = parseColoursConfig(coloursConfig)
                    parseMainConfig(config, parsedColoursConfig)
            }
    }
}


func parseMainConfig (config: NSDictionary, colours: [String:UIColor]) {
    //Extract some key config settings
    if  let nav = config["NAVIGATION_BAR"] as? NSDictionary,
        let button = config["DEFAULT_BUTTON"] as? NSDictionary,
        let action_button = config["ACTION_BUTTON"] as? NSDictionary,
        let api = config["API"] as? NSDictionary {
            
            setThemes(nav, button, action_button, colours)
            setApi(api)
            
            let defaults:[String:[String:AnyObject]] = [
                "pincode_enabled" : [
                    "type": "bool",
                    "value": false
                ]
            ]
            setUsersDefaults(defaults, false)
    }
}

func setThemes (nav:NSDictionary, button:NSDictionary, action_button:NSDictionary, colours: [String:UIColor]) {
    //Navigation props
    if let navBackground = nav["BACKGROUND"] as? String, let navText = nav["TEXT_COLOUR"] as? String, let navBarStyle = nav["THEME"] as? Int {
        
        //Navigation background
        if let navBackgroundColour = colours[navBackground] {
            UINavigationBar.appearance().barTintColor = navBackgroundColour
        }
        //Navigation text colour
        if let navTextColour = colours[navText] {
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
    if let buttonBackground = button["BACKGROUND"] as? String,
        let buttonText = button["TEXT_COLOUR"] as? String {
            //Default button style
            if let buttonBackgroundStyle = colours[buttonBackground] {
                Styles.DefaultTheme["backgroundColour"] = buttonBackgroundStyle
            }
            
            //Default button style
            if let buttonTextColour = colours[buttonText] {
                Styles.DefaultTheme["textColour"] = buttonTextColour
            }
    }
    
    //Button props
    if let actionButtonBackground = action_button["BACKGROUND"] as? String,
        let actionButtonText = action_button["TEXT_COLOUR"] as? String {
            //Default button style
            if let actionButtonBackgroundStyle = colours[actionButtonBackground] {
                Styles.ActionTheme["backgroundColour"] = actionButtonBackgroundStyle
            }
            
            //Default button style
            if let actionButtonTextColour = colours[actionButtonText] {
                Styles.ActionTheme["textColour"] = actionButtonTextColour
            }
    }

}

func setApi (api:NSDictionary) {
    //API
    var restfullFactorySet = false
    if let apiUrl = api["URL"] as? String,
        let auth = api["AUTH"] as? NSDictionary {
            //The base api request url, used in every restfull request to the api
            BaseRequest.BASE_URI = apiUrl
            //Auth is enbaled
            if let authEabled = auth["ENABLED"] as? Int {
                //Auth enabled, set the resftfull factory with the auth type set in the config
                if authEabled == 1 {
                    //attempt to extract the type and settings
                    if let type = auth["TYPE"] as? String,
                        let settings = auth["SETTINGS"] as? [String:String] {
                            
                            if let auth = AuthFactory.create(type) {
                                auth.setSettings(settings);
                                ServiceLocator.sharedInstance.registerFactory("RestFull", factory: { (sl) -> AnyObject in
                                    let restfull = RestFull()
                                    restfull.setAuthentication(auth)
                                    
                                    return restfull
                                })
                                
                                restfullFactorySet = true
                            }
                    }
                }
            }
    }
    //default fallback, auth isn't enabled
    if !restfullFactorySet {
        ServiceLocator.sharedInstance.registerFactory("RestFull", factory: { (sl) -> AnyObject in
            return RestFull()
        })
    }

}

func setUsersDefaults (defaults:[String:[String:AnyObject]], reset:Bool) {
    if reset {
        //todo: reset
    }
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    for (key, settings) in defaults {
        if userDefaults.valueForKey(key) == nil {
            switch settings["type"] as! String {
                case "bool":
                    userDefaults.setBool(settings["value"] as! Bool, forKey: key)
                break
                
                default:
                    userDefaults.setObject(settings["value"] as! String, forKey: key)
                break;
            }
        }
    }
}

func registerCurrentUser () {
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    if let Username: String = userDefaults.valueForKey("username") as? String, let Id : String = userDefaults.valueForKey("id") as? String{
        ServiceLocator.sharedInstance.registerService("customer", service: Customer(_name: Username, _id: Id))
    }
    
}