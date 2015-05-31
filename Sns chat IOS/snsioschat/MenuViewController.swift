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
        
        //logo.image = UIImage(named: "logo-new.png");
        navigationItem.setHidesBackButton(true, animated: true)
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
