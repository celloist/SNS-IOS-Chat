//
//  MenuViewController.swift
//  Sns chat IOS
//
//  Created by User on 29/04/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    private var customer = ServiceLocator.sharedInstance.getService("customer") as? Customer
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.viewControllers.removeAtIndex((self.navigationController?.viewControllers.count)! - 2)
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        //logo.image = UIImage(named: "logo-new.png");
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("Hide nav")
        //navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    @IBAction func moveToOtherScene(sender: UIButton) {
        let option = sender.currentTitle!
        switch option {
//        case "Chats" :
//            self.performSegueWithIdentifier("Chats", sender: self)
        case "FAQ" :
            self.performSegueWithIdentifier("FAQ", sender: self)
        case "Settings" :
            self.performSegueWithIdentifier("Settings", sender: self)
        default :
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Chats"{
            var dest = segue.destinationViewController as! ChatsController
            
        }
    }

}
