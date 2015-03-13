//
//  ChatController.swift
//  Sns chat IOS
//
//  Created by User on 11/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class ChatController: UIViewController , UITableViewDataSource , UITableViewDelegate
{
    
    private let chatModel = RestFull()
    @IBOutlet var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var chat:Chat?
    
    
    var customer:Customer?
    
    override func viewDidLoad(){
        super.viewDidLoad()
       
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        var nib = UINib(nibName: "ViewTableMessageCell", bundle: nil)
       self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
      
    self.tableView.dataSource = self
        println(chat?.id)
         self.tableView.reloadData()
    }
    @IBAction func SendMessage(sender: UIButton) {
        var url:String = "https://frozen-inlet-5594.herokuapp.com/customers/\(self.customer!.id)/chats/\(chat!.id)/messages"
        println(url)
        println(chatField.text)
        var param: [String:AnyObject] = ["message": "\(chatField.text)"]
      
        
        // var param:[AnyObject] = "\"message\":\"\(chatField.text)\""
        chatModel.postData(url, params: param, callback: {(success : Bool, data: [String:AnyObject]) in
            if success {
           
                self.chat?.messages.append(Message(_user: self.customer,_text:"\(self.customer?.name) : \(self.chatField.text)",_time: "time"))
                self.tableView.reloadData()
                
            }
            
        });

    }
    /*
    @IBAction func sendMessage(sender: UIButton) {
        var url:String = "https://frozen-inlet-5594.herokuapp.com/customers/\(self.customer?.id)/chats/\(chat?.id)/messages"
        println(url)
        
        let param: [String:AnyObject] = ["message": "\(chatField.text)"]
        
        
       // var param:[AnyObject] = "\"message\":\"\(chatField.text)\""
        chatModel.postData(url, params: param, callback: {(success : Bool, data: [String:AnyObject]) in
            if success {
                println("-")
                self.chat?.messages.append(Message(_user: self.customer,_text: self.chatField.text,_time: "time"))
                self.tableView.reloadData()
                
            }
            
        });
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println("-------------------")
        if let count = chat?.messages.count {
            println(count)
            return count
        }else{
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        
        var cell : MessageCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as MessageCell
        
        // Get the corresponding candy from our candies array
        if  var chat = self.chat{
            
           

            // Configure the cell
         cell.timeStamp.text = chat.messages[indexPath.row].time
            cell.message.text = chat.messages[indexPath.row].text
            
        }
        
        return cell
    }
    

    

}
