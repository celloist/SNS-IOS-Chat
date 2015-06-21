//
//  ChatTableViewController.swift
//  SNS tester
//
//  Created by Mark Jan Kamminga on 19-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit


class ChatTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var timer = NSTimer()
    private let chatModel = ServiceLocator.sharedInstance.createFactoryService("RestFull") as! RestFull
    private var customer = ServiceLocator.sharedInstance.getService("customer") as? Customer
    private var chatFactory:ChatFactory?
    
    
    
    var chat:Chat?
    
    @IBOutlet weak var textViewBottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var sendMessageContent: UITextField!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: Storyboard.CellReuseIdentifier)
        self.sendMessageContent.delegate = self
        self.tableView.dataSource = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
        scrolToBottom()
        // Scrolls to the bottom of the list
       // tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: chat!.messages.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        if let concreteChat = chat {
            self.title = concreteChat.subject
        }
        
        startTimer()
        
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        textViewBottomConstaint.constant = 0.0
    }
    
    //Autoadjust the view to make the keypad fit the screen
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                textViewBottomConstaint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    private func startTimer () {
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("updateUI"), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }
    
    @IBAction func sendMessage(sender: UIButton?) {
        if sendMessageContent.text != "" {
            self.view.endEditing(true)
            sendMessageContent.resignFirstResponder()
            
            var url:String = BaseRequest.concat("customers/\(self.customer!.id)/chats/\(chat!.id)/messages")
            var param: [String:AnyObject] = ["message": "\(sendMessageContent.text)"]
            self.sendMessageContent.text = ""
            chatModel.postData(url, params: param, callback: {(success : Bool, data: [String:AnyObject]) in
                dispatch_async(dispatch_get_main_queue()) {
                    if success {
                        self.getData()
                    }
                }
            });
        }
    }
    
    func getData(){
        //println("Called: customers/\(self.customer!.id)/chats/\(chat!.id)/messages")
        var url = BaseRequest.concat("customers/\(self.customer!.id)/chats/\(chat!.id)/messages")
        //Lazy init. 
        if chatFactory == nil {
            chatFactory = ChatFactory(customer: customer!)
        }
        let prevoiusNumSections = self.tableView.numberOfRowsInSection(0)
        chatModel.getData(url) { (success, data) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    if let result = data["result"] as? NSDictionary {
                        self.chat = self.chatFactory!.createChatFromJson(result["data"]!, category: nil)
                        
                        if prevoiusNumSections != self.chat?.messages.count {
                            self.tableView.reloadData()
                            self.scrolToBottom()
                        }
                    }
                }
            }
        }
    }
    
    private func scrolToBottom () {
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        //Work around, table scroll after customheigts calc
        dispatch_after(delayTime, dispatch_get_main_queue(), {
            var iPath = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0)-1,
                inSection: self.tableView.numberOfSections()-1)
            self.tableView.scrollToRowAtIndexPath(iPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        })
    }
    
    func updateUI () {
        getData()
        
    }
    // MARK: - Table view data source
    private struct Storyboard {
        static let SystemCellReuseIdentifier = "SystemMessage"
        static let UserCellReuseIdentifier = "UserMessage"
        static let EmployeeCellReuseIdentifier = "EmployeeMessage"
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let count = chat?.messages.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if  let chat = self.chat {
            let message = chat.messages[indexPath.row]
            //println(message.sender)
            let cell = tableView.dequeueReusableCellWithIdentifier(identifierFromType(message.sender), forIndexPath: indexPath) as! MessageTableViewCell
           cell.message = message
                        // Configure the cell
           
           return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private  func identifierFromType (id: String) -> String {
        switch id {
        case "employee":
            return Storyboard.EmployeeCellReuseIdentifier
            
        case "user":
            return Storyboard.UserCellReuseIdentifier
            
        case "system":
            return Storyboard.SystemCellReuseIdentifier
            
        default:
            return Storyboard.UserCellReuseIdentifier
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage(nil)
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
