//
//  ChatsController.swift
//  Sns chat IOS
//
//  Created by User on 07/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ChatsController : UIViewController , UITableViewDataSource , UITableViewDelegate
{
    private var chatModel = ServiceLocator.sharedInstance.createFactoryService("RestFull") as! RestFull
    private var customer  = ServiceLocator.sharedInstance.getService("customer") as? Customer
    private var chats:[Chat]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Restfull model
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: Storyboard.CellReuseIdentifier)
        
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
        self.tableView.dataSource = self
      
        if let id = customer?.id {        
            var url = BaseRequest.concat("customers/" + id + "/chats")
            
            chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
                dispatch_async(dispatch_get_main_queue()) {
                    if success {
                        let chatFactory = ChatFactory(customer: self.customer!)
                        
                        if let result = data["result"] as? NSDictionary {
                            let chats = chatFactory.createChatsFromJson(result["data"]!)
                            self.chats = chats
                            self.tableView.reloadData()
                        }
                    }
                }
            });
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let count = chats?.count {
           
            return count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc : ChatTableViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
        
        vc.chat = self.chats?[indexPath.row]
        
        self.showViewController(vc as UITableViewController, sender: vc)
        
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Cell"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        if  var chat = self.chats{
            // Configure the cell
            cell.textLabel!.text = chat[indexPath.row].messages[0].text
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "startChat" {
            if let startChatController = segue.destinationViewController as? StartChatViewController {
                
                startChatController.customer = customer
            }
        }
    }*/
    
}