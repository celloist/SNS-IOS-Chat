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
        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge |
            UIUserNotificationType.Sound
        let notificationSetting:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSetting)
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
        
        return true
    
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        
        
        
        // default value is not set or not an NSDate
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        

        
        //for var i = 0; i < deviceToken.length; i++ {
         //   tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        //}
        
        println("tokenString: \(deviceTokenString)");
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(deviceTokenString, forKey: "deviceToken")
        userDefaults.synchronize()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let customer = ServiceLocator.sharedInstance.getService("customer") as? Customer{
            var dict:NSDictionary = notification.userInfo!
            // make sure this is not called when localnotifation is recieved but when tapped
            if notification.fireDate?.timeIntervalSinceNow < -1{
                if let chatId = dict["ChatId"] as? String{
                    var url = BaseRequest.concat("customers/\(customer.id)/chats/\(chatId)/messages")
                    let chatModel = RestFull()
                    chatModel.getData(url) {(success, data) in
                        dispatch_async(dispatch_get_main_queue()){
                                if success{
                                    let chatFactory = ChatFactory(customer: customer)
                                    
                                    if let result = data["result"] as? NSDictionary{
                                        if let chat = chatFactory.createChatFromJson(result["data"]!,category:nil) {
                                            var vs:UIViewController = self.window!.rootViewController!
                                            let vc : ChatTableViewController! = vs.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
                                            var userDefaults = NSUserDefaults.standardUserDefaults()
                                            
                                            vc.chat = chat
                                            
                                            
                                            //TODO change to use nsobject
                                            vs.showViewController(vc as UITableViewController, sender: vc)
                                            
                                        }
                                        
                                    }
                                }
                            }
                    }
                }
            }
        }//opened from a push notification when the app was on background
        
    }
 
    
    func application(application: UIApplication, didReceiveRemoteNotification: [NSObject : AnyObject]){
        registerCurrentUser();
        if application.applicationState == UIApplicationState.Active {
                var  localNotification  = UILocalNotification()
                localNotification.userInfo = didReceiveRemoteNotification;
                
                if let message  = didReceiveRemoteNotification["text"] as? String {
                    localNotification.alertBody = message;
                    
                }
                
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
                localNotification.timeZone = NSTimeZone.defaultTimeZone()
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
        } else if let customer = ServiceLocator.sharedInstance.getService("customer") as? Customer {
                    var dict:NSDictionary = didReceiveRemoteNotification;
                // make sure this is not called when localnotifation is recieved but when tapped
             
                    if let chatId = dict["ChatId"] as? String {
                        var url = BaseRequest.concat("customers/\(customer.id)/chats/\(chatId)/messages")
                        let chatModel = RestFull()
                        
                        chatModel.getData(url) {(success, data) in
                            dispatch_async(dispatch_get_main_queue()){
                                if success {
                                    let chatFactory = ChatFactory(customer: customer)
                                    
                                    if let result = data["result"] as? NSDictionary {
                                        if let chat = chatFactory.createChatFromJson(result["data"]!,category:nil) {
                                            var vs:UIViewController = self.window!.rootViewController!
                                            
                                            let vc : ChatTableViewController! = vs.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
                                            var userDefaults = NSUserDefaults.standardUserDefaults()
                                            
                                            vc.chat = chat
                                            
                                            //TODO change to use nsobject
                                            vs.showViewController(vc as UITableViewController, sender: vc)
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                
                //TODO update Model
            }
        
    }
    
    private func registerCurrentUser () {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        
        if let Username: String = userDefaults.valueForKey("username") as? String, let Id : String = userDefaults.valueForKey("id") as? String{
            ServiceLocator.sharedInstance.registerService("customer", service: Customer(_name: Username, _id: Id))
        }

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

