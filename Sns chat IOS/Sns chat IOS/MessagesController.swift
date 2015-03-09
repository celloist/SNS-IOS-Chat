//
//  MessagesController.swift
//  Sns chat IOS
//
//  Created by User on 09/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class MessagesController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    var _chat:chat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println("-------------------")
        if let count = _chat?.messages.count {
            println(count)
            return count
        }else{
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        println("-+-")
        // Get the corresponding candy from our candies array
        if  var messages = self._chat?.messages{
            println("-+-1")
            
            // Configure the cell
            cell.textLabel!.text = chat[indexPath.row].customer.name + " : " + chat[indexPath.row].messages[0].text
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }


}
