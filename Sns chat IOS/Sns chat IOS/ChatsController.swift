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
    private let request  = Request()
    private let chatModel = RestFull()
    private var chats:[Chat]?
    var customer:Customer?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: Storyboard.CellReuseIdentifier)
 
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
        self.tableView.dataSource = self
      
        if let id = customer?.id {        
            var url:String = "https://quiet-ocean-2107.herokuapp.com/customers/" + id + "/chats"
            chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
                dispatch_async(dispatch_get_main_queue()) {
                    if success {
                        self.chats = self.request.getChats(data,customer : self.customer!)
                        self.tableView.reloadData()
                        
                    }
                }
            });
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let count = chats?.count {
            println(count)
            return count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc : ChatTableViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Chat") as ChatTableViewController
        
        vc.customer = self.customer
        vc.chat = self.chats?[indexPath.row]
        self.showViewController(vc as UITableViewController, sender: vc)
        
    }
    private struct Storyboard {
        static let CellReuseIdentifier = "Cell"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        if  var chat = self.chats{
            // Configure the cell
            cell.textLabel!.text = chat[indexPath.row].messages[0].text
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
}