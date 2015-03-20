//
//  ChatTableViewController.swift
//  SNS tester
//
//  Created by Mark Jan Kamminga on 19-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit


class ChatTableViewController: UITableViewController {
    // let requestModel = RestFull()
    
    var timer = NSTimer()
    private let chatModel = RestFull()
    var chat:Chat?
    private let request  = Request()
    var customer:Customer?
    
    @IBAction func chatField(sender: UITextField) {
        var url:String = "https://frozen-inlet-5594.herokuapp.com/customers/\(self.customer!.id)/chats/\(chat!.id)/messages"
        println(url)
        println(sender.text)
        var param: [String:AnyObject] = ["message": "\(sender.text)"]
        
        
        // var param:[AnyObject] = "\"message\":\"\(chatField.text)\""
        chatModel.postData(url, params: param, callback: {(success : Bool, data: [String:AnyObject]) in
            dispatch_async(dispatch_get_main_queue()) {
                
                if success {
                    
                }
            }
        });
        
        
    }
    func getData(){
        
        var url:String = "https://frozen-inlet-5594.herokuapp.com/customers/" + self.customer!.id  + "/chats"
        
        chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    println("-")
                    
                    self.chat = self.request.getChats(data,customer : self.customer!)[0]
                    self.tableView.reloadData()
                    
                }
            }
        });
        
        
        
        
        
        
        
        
        /*
        var url = "https://frozen-inlet-5594.herokuapp.com/customers/" + self.customer!.id + "/chats" + self.chat.id + "/messages"
        chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
        dispatch_async(dispatch_get_main_queue()) {
        if success {
        println("-")
        self.chats = self.request.getChats(data,customer : self.customer!)
        self.tableView.reloadData()
        
        }
        }
        });
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        self.tableView.reloadData()
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("implementUpdateUITimerAndChangefTheName"), userInfo: nil, repeats: true)
    }
    
    
    
    func implementUpdateUITimerAndChangefTheName () {
        println("Called timer:::")
        getData()
    }
    // MARK: - Table view data source
    
    
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Message"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let count = chat?.messages.count {
            println(count)
            return count
        }else{
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MessageTableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as MessageTableViewCell
        
        
        
        // Get the corresponding candy from our candies array
        if  var chat = self.chat{
            
            
            
            // Configure the cell
            cell.timestamp.text = chat.messages[indexPath.row].time
            cell.chatMessage.text = chat.messages[indexPath.row].text
            
        }
        
        return cell
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
