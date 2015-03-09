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
    private var chats:[chat]?
    
    var customer:Customer?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        if let id = customer?.id {
            var url:String = "https://frozen-inlet-5594.herokuapp.com/customers/" + id + "/chats"
            println(url)

            chatModel.getData(url, callback: {(success : Bool, data: [String:AnyObject]) in
                if success {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.chats = self.request.getChats(data,customer : self.customer!)
                        self.tableView.reloadData()
                    }
                    
                }
              
            });
                //self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println("-------------------")
        if let count = chats?.count {
            println(count)
            return count
        }else{
            return 0
        }
    }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("===========")
        
        //ToDo change screen on click to chat
        
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        println("-+-")
        // Get the corresponding candy from our candies array
        if  var chat = self.chats{
            println("-+-1")
            
            // Configure the cell
            cell.textLabel!.text = chat[indexPath.row].customer.name + " : " + chat[indexPath.row].messages[0].text
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }

   
 
    
}