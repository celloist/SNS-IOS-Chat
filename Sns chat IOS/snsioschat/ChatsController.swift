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
    private var isRetreivingData = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Restfull model
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: Storyboard.CellReuseIdentifier)
        self.tableView.tableFooterView = UIView()

        self.tableView.reloadData()
        self.tableView.dataSource = self
        getData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    private func getData () {
        if !self.isRetreivingData {
            if let id = customer?.id {
                var url = BaseRequest.concat("customers/" + id + "/chats")
                self.isRetreivingData = true
                
                chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.isRetreivingData = false
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let count = chats?.count {
           
            return count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ChatItem") as! ChatTableViewController
        vc.chat = self.chats?[indexPath.row]
        
        self.showViewController(vc, sender: vc)
        
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Cell"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! ChatTableViewCell
        if  let chats = self.chats{
            // Configure the cell
            let chat = chats[indexPath.row]
            cell.chat = chat
                        
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