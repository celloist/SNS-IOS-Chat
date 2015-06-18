//
//  PincodeViewController.swift
//  Sns chat IOS
//
//  Created by User on 18/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class PincodeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var pincodeLabel: UILabel!
    var first: Bool! = true
    
    @IBAction func digit(sender: ThemeUIButton) {
        if(first == true)
        {
            first = false
            pincodeLabel.text = "";
        }
   
        let digit = sender.currentTitle!
        pincodeLabel.text = pincodeLabel.text! + digit
 
    }
    
    @IBAction func enter(sender: AnyObject) {
        first = true
        
        //insert segue and pincheck code here
        
        pincodeLabel.text = "";
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
