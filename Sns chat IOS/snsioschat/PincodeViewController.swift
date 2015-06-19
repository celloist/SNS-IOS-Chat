//
//  PincodeViewController.swift
//  Sns chat IOS
//
//  Created by User on 18/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class PincodeViewController: UIViewController {
    private var pincode = [String]()
    private let savedPincode = NSUserDefaults.standardUserDefaults().valueForKey("pincode") as! Int
    @IBOutlet weak var firstInput: UITextField!
    @IBOutlet weak var secondInput: UITextField!
    @IBOutlet weak var thirdInput: UITextField!
    @IBOutlet weak var fourthInput: UITextField!
    @IBOutlet weak var fifthInput: UITextField!
    
    private var inputs = [Int:UITextField]()
    
    @IBOutlet weak var code: UILabel!
    var canAddDigit:Bool {
        return pincode.count < 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputs[0] = firstInput
        inputs[1] = secondInput
        inputs[2] = thirdInput
        inputs[3] = fourthInput
        inputs[4] = fifthInput
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var pincodeLabel: UILabel!
    
    @IBAction func digit(sender: ThemeUIButton) {
        if canAddDigit {
            let digit = sender.currentTitle!
            
            addDigit(digit)
        }
    }
    
    @IBAction func backspace(sender: AnyObject) {
        if pincode.count > 0 {
            inputs[pincode.count - 1]?.text = ""
            pincode.removeLast()
        }
    }
    
    func addDigit (digit:String) {
        if canAddDigit {
            pincode.append(digit)
            inputs[pincode.count - 1]?.text = "*"
            if pincode.count == 5 {
                var hashedpincode = ""
                hashedpincode = hashedpincode.join(pincode)
                
                enterPin(hashedpincode)
            }
        }
    }
    
    func enterPin (pin:String) -> Bool {
        if count(pin) == 5 {
            if pin.hashValue == savedPincode {
                segue()
                
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Navigation
    
    private func segue () {
        let vc : MenuViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
        self.showViewController(vc, sender: vc)
        self.navigationController?.viewControllers.removeAtIndex((self.navigationController?.viewControllers.count)! - 2)
    }
}
