//
//  ChatFactory.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class ChatFactory: NSObject {
    let categoryFactory = CategoryFactory()
    let chatMessageFactory:ChatMessageFactory
    let customer:Customer
    
    init (customer: Customer) {
        chatMessageFactory = ChatMessageFactory(customer: customer)
        self.customer = customer
    }
    
    func createChatFromJson (data: AnyObject) -> Chat? {
        if let result = data as? NSDictionary {
            if let id = result["_id"] as? String {
                if let rawCategory = result["category"] as? NSDictionary {
                    if let category = categoryFactory.createCategoryFromJson(rawCategory) {
                        let chat =  Chat(id: id, customer: customer, category: category)
                        
                        if result["messages"] != nil {
                            //Parse the messages from the data object
                            let parsedMessages = chatMessageFactory.createMessagesFromJson(result["messages"]!)
                            //return the chat object
                            chat.appendMessages( parsedMessages )
                        }
                        
                        return chat
                        
                    }
                }
            }
        }
        
        return nil
    }
    
    func createChatsFromJson (data:AnyObject) -> [Chat] {
        var chats = [Chat]()
        if let payload  = data as? NSArray {
            for rawItem in payload {
                if let chat = createChatFromJson(rawItem) {
                    chats.append( chat )
                }
            }
        }
        
        return chats
    }
}

class ChatMessageFactory {
    let customer:Customer
    
    init (customer: Customer) {
        self.customer = customer
    }
    
    func createMessagesFromJson (data:AnyObject) -> [Message] {
        var returnData = [Message]()
        
        if let result = data as? NSArray {
            //Loop raw messages
            for rawMessage in result {
                //attempt to create a message
                if let message = createMessageFromJson(rawMessage) {
                    //if successfull, append to the array
                    returnData.append(message)
                }
            }
        }
        return returnData
    }
    
    func createMessageFromJson (data: AnyObject) -> Message? {
        var user:User?
        var isEmployee:Bool! = data["isEmployee"] as? Bool
        
        if var text = data["text"] as? String {
            if let employee = data["isEmployee"] as? Bool {
                if !employee  {
                    text = "\(customer.name) : \(text)"
                    user = customer
                } else {
                    //TODO get medewerker
                    
                    text = "employee : \(text)"
                }
                
                if let time = data["timeStamp"] as? String{
                    return Message(_user: user,_text: text,_time: time, _isEmployee: isEmployee)
                }
            }
        }
        
        return nil
    }
}
