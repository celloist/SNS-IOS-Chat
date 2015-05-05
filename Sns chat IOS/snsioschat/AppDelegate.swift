//
//  AppDelegate.swift
//  SNSchatIOS
//
//  Created by Jeroen Guelen on 23/04/15.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge |
            UIUserNotificationType.Sound
        let notificationSetting:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSetting)
        
        
        return true
    }
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
       
            
        
            // default value is not set or not an NSDate
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for var i = 0; i < deviceToken.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        println("tokenString: \(tokenString)");
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(tokenString, forKey: "deviceToken")
        userDefaults.synchronize()
        
  
        
    }
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        // caled when application was not in background or foreground when recieved notification
        var vs:UIViewController = self.window!.rootViewController!;
        
        let vc : ChatTableViewController! = vs.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
        var userDefaults = NSUserDefaults.standardUserDefaults();
        
        //vc.customer = Customer(_name: userDefaults.valueForKey("name") as! String,_id: userDefaults.valueForKey("id") as! String)
       // vc.chatid = 0; //TODO change to use nsobject
        
        vs.showViewController(vc as UITableViewController, sender: vc)


        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        var vs:UIViewController = self.window!.rootViewController!;
      
        let vc : ChatTableViewController! = vs.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
        var userDefaults = NSUserDefaults.standardUserDefaults();
        
        vc.customer = Customer(_name: userDefaults.valueForKey("name") as! String,_id: userDefaults.valueForKey("id") as! String)
        vc.chatid = 0; //TODO change to use nsobject
        
        vs.showViewController(vc as UITableViewController, sender: vc)

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

