//
//  StartChatViewController.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 22-03-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import UIKit

class StartChatViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var categoriesPicker: UIPickerView!
    @IBOutlet weak var questionTextbox: UITextField!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    private var categories:[String] = []
    private var categoryKeys:[String] = []
    
    private var selectedCategory:Int = 0
    private var customer = ServiceLocator.sharedInstance.getService("customer") as? Customer
    private let restfull = ServiceLocator.sharedInstance.createFactoryService("RestFull") as! RestFull
    private var chat:Chat?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidden = true
        categoriesPicker.dataSource = self
        categoriesPicker.delegate = self
        questionTextbox.delegate = self
        
        restfull.getData(BaseRequest.concat("categories"), callback: {( success : Bool, data: [String:AnyObject]) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    if let result = data["result"] as? NSDictionary {
                        if let categories = result["data"] as? NSArray {
                            for rawCategory in categories {
                                
                                //category
                                if let category = rawCategory as? NSDictionary {
                                    //name
                                    if let name = category["name"] as? String {
                                        //Key
                                        if let key = category["_id"] as? String {
                                            self.categories.append(name)
                                            self.categoryKeys.append(key)
                                        }
                                    }
                                }
                            }
                        }
                        //Reload
                        self.categoriesPicker.reloadAllComponents()
                    }
                }
            }
        })
    }
    
    //Mark: - UI
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func startNewChat(sender: UIButton) {
        let categoryId = categoryKeys[selectedCategory];
        let categoryName = categories[selectedCategory];
        var category = Category(id: categoryId , name: categoryName)
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        let url = BaseRequest.concat("customers/\(customer!.id)/chats")

        restfull.postData(url, params: ["category" : categoryId, "message" : questionTextbox.text]) {( success, data) in
            
            if success {
                let chatFactory = ChatFactory(customer: self.customer!)
                
                if let baseData = data["result"] as? NSDictionary {
                    if let chat = chatFactory.createChatFromJson(baseData["data"]!, category: category) {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.hidden = true
                            
                            let vc : ChatTableViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("Chat") as! ChatTableViewController
                            
                            vc.chat = chat
                            self.showViewController(vc as UITableViewController, sender: vc)
                            
                        }
                    }
                }
            }

        }
        
    }
}
