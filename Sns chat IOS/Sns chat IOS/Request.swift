//
//  Request.swift
//  Sns chat IOS
//
//  Created by User on 06/03/15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class Request{
    private let chatModel  = RestFull()
    
    func getCustomers(data:[String:AnyObject])->[Customer]{
        var customers:[Customer] = [Customer]();
        
        if let result = data["result"] as? NSDictionary {
            if let payload  = result["data"] as? NSArray {
                
                //Loop through all the customers
                for rawItem in payload {
                    if let customer = rawItem as? NSDictionary{
                        
                        
                        if let name:String = customer["name"] as? String
                        {
                            
                            if let id:String = customer["_id"] as? String
                            {/* adding chats to customer not necesary ?yet?
                                
                                var _chats:[Chat] = [Chat]();
                                
                                if let chats = customer["Chats"] as? NSArray
                                {
                                for rawChat in chats
                                {
                                if let chatFrame = rawChat as? NSDictionary
                                {
                                if let chatid:String = chatFrame["id"] as? String{
                                
                                if let chatcustomerid
                                }
                                
                                }
                                
                                var _chat:Chat = Chat()
                                }
                                }
                                */
                                
                                
                                customers.append(Customer(_name:name,_id:id));
                                
                            }
                        }
                        
                        
                    } else
                    {
                        println("Filed")
                    }
                }
            }
            
        }
        
        return customers;
    }
    func getChats(data:[String:AnyObject],customer:Customer)->[Chat]
    {
        var chats:[Chat] = [Chat]()
        if let result = data["result"] as? NSDictionary {
            
            if let payload  = result["data"] as? NSArray {
                
                for rawItem in payload {
                    
                    if let chatid = rawItem["_id"] as? String{
                        var _messages:[Message] = [Message]()
                        
                        if let messages = rawItem["messages"] as? NSArray{
                            
                            var user:User?
                            for message in messages{
                                
                                var text:String = ""
                                if var _text = message["text"] as? String{
                                    text = _text
                                }
                                
                                if let employee = message["employee"] as? Bool{
                                    
                                    if !employee  {
                                        
                                        
                                        text = "\(customer.name) : \(text)"
                                        user = customer
                                    }else{
                                        //TODO get medewerker
                                        
                                        text = "employee : \(text)"
                                        user = nil
                                        
                                        
                                    }
                                    if let time = message["timeStamp"] as? String{
                                        
                                        
                                        _messages.append(Message(_user: user,_text: text,_time: time))
                                        
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        chats.append(Chat(id: chatid ,_customer: customer ,_messages: _messages))
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
        }
        println(" chats \(chats)")
        return chats
    }
    /*
    
    func getMessages(data:[String:AnyObject],customer:Customer)->[Message]{
    
    
    /*
    var messages:[Message] = [Message]()
    if let result = data["result"] as? NSDictionary {
    
    if let payload  = result["data"] as? NSArray {
    for rawItem in payload {
    if let chatid = rawItem["messages"] as? String{
    
    
    
    
    }
    
    }
    
    }
    }
    */
    
    
    return nil
    }
    */
    
    
    
}