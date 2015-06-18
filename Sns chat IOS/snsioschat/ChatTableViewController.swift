//
//  ChatTableViewController.swift
//  SNS tester
//
//  Created by Mark Jan Kamminga on 19-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit


class ChatTableViewController: UITableViewController,UITextFieldDelegate {
    var timer = NSTimer()
    private let chatModel = ServiceLocator.sharedInstance.createFactoryService("RestFull") as! RestFull
    private var customer = ServiceLocator.sharedInstance.getService("customer") as? Customer
    private var chatFactory:ChatFactory?
    
    var chat:Chat?
    
    
    @IBOutlet weak var sendMessageContent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendMessageContent.delegate = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
        
        // Scrolls to the bottom of the list
       // tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: chat!.messages.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("updateUI"), userInfo: nil, repeats: true)
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
                        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chat!.messages.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    }
                }
            });
        }
    }
    
    func getData(){
        var url = BaseRequest.concat("customers/\(self.customer!.id)/chats/\(chat!.id)/messages")
        //Lazy init. 
        if chatFactory == nil {
            chatFactory = ChatFactory(customer: customer!)
        }
        
        chatModel.getData(url) { (success, data) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    if let result = data["result"] as? NSDictionary {
                        self.chat = self.chatFactory!.createChatFromJson(result["data"]!, category: nil)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func updateUI () {
        getData()
        
    }
    // MARK: - Table view data source
    private struct Storyboard {
        static let CellReuseIdentifier = "Message"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let count = chat?.messages.count {
            return count
        } else {
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MessageTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! MessageTableViewCell
        
        
        if  var chat = self.chat{
            // Configure the cell
            cell.message = chat.messages[indexPath.row]
        }
        
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage(nil)
        return true
    }
    
    /*
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
