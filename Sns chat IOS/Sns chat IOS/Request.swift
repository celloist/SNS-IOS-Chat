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
                         println("cust")
                        //Loop through all the customers
                        for rawItem in payload {
                                 if let customer = rawItem as? NSDictionary{
                                     println("ab")
                                
                                 if let name:String = customer["name"] as? String
                                 {
                                     println("ac")
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
                                    
                                         println("a")
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
    func getChats(data:[String:AnyObject],customer:Customer)->[chat]
    {
        var chats:[chat] = [chat]()
        if let result = data["result"] as? NSDictionary {
            println("\(result)")
            if let payload  = result["data"] as? NSArray {
                println("2-")
                for rawItem in payload {
                    println("3-")
                    if let chatid = rawItem["_id"] as? String{
                    var _messages:[Message] = [Message]()
                    println(" 2- \(rawItem)")
                    if let messages = rawItem["messages"] as? NSArray{
                         println("message1111s")
                        
                        var user:User?
                        for message in messages{
                            println("messages")
                            var text:String = ""
                            if var _text = message["text"] as? String{
                                text = _text
                            }
                            
                                if let id = message["_id"] as? String{
                                    println("test")
                                        if id == customer.id {
                                            println("test1")

                                            text = "\(customer.name) : \(text)"
                                            user = customer
                                        }else{
                                            //TODO get medewerker
                                            println("test2")

                                            text = "employee : \(text)"
                                    
                                        }
                                        if let time = message["timeStamp"] as? String{
                                            println("test3")

                                            _messages.append(Message(_user: user,_text: text,_time: time))
                                        
                                        }
                                
                                 }
                            
                            
                         
                        }
                        
                        }
                        println("append")
                       chats.append(chat(id: chatid ,_customer: customer ,_messages: _messages))
                     
                    }
              
                    
                  
                    
                    
                    
                }
                
                
            }
            
        }
        println(" chats \(chats)")
        return chats
    }

}