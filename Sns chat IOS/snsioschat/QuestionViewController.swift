//
//  QuestionViewController.swift
//  Sns chat IOS
//
//  Created by User on 06/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var faqQuestion : FaqQuestion?
  
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fQuestion = faqQuestion?.question{
            question.text = fQuestion
        }
        if let fAnwser = faqQuestion?.answer{
            answer.text = fAnwser
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let startChatController = segue.destinationViewController as? StartChatViewController {
            startChatController.preselectedCategory = faqQuestion?.category
        }
    }
}
