//
//  FaqController.swift
//  Sns chat IOS
//
//  Created by User on 06/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//



import UIKit

class FaqController: UIViewController {
    
    private var restFull = ServiceLocator.sharedInstance.createFactoryService("RestFull") as! RestFull
   // var sectionTitleArray : NSMutableArray = NSMutableArray()
    var sectionContentDict : NSMutableDictionary = NSMutableDictionary()
    var arrayForBool : NSMutableArray = NSMutableArray()
    private var categories : [Category]?;
    private var questions : [FaqQuestion]?;
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FAQ"
        // Do any additional setup after loading the view, typically from a nib.
        
        restFull.getData(BaseRequest.concat("categories"), callback: {( success : Bool, data: [String:AnyObject]) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if success {
                    
                    if let result = data["result"] as? NSDictionary {
                        var categoryFactory = CategoryFactory()
                        
                        self.categories = categoryFactory.createCategoriesFromJson(result["data"]!)
                        
                        self.restFull.getData(BaseRequest.concat("faq"), callback: {(success : Bool, data: [String:AnyObject]) in
                            dispatch_async(dispatch_get_main_queue()) {
                                if success {
                                    let faqFactory = FaqFactory();
                                    
                                    if let faqResult = data["result"] as? NSDictionary {

                                        self.questions = faqFactory.createQuestionsFromJson(faqResult["data"]!)
                                        for category in self.categories!{
                                            self.arrayForBool.addObject("0");
                                            var question = [FaqQuestion]();


                                            for quest in self.questions!{
                                                if quest.category.name == category.name {
                                                    question.append(quest);
                                                }
                                            }
                                            
                                            [self.sectionContentDict .setValue(question, forKey:category.name )]
                                        }
                                        
                                        self.tableView.reloadData()
                                       
                                    }
                                }
                            }
                        });
                    }
                }
            }
        })

        self.tableView.reloadData()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let cat = categories {
            return cat.count
        }else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            
            var tps = categories?[section].name;
            var count1 = (sectionContentDict.valueForKey(tps!)) as! NSArray
            return count1.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories?[section].name
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if arrayForBool .objectAtIndex(indexPath.section).boolValue == true {
            return 100
        }
        
        return 2;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor.grayColor()
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = categories?[section].name
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool .objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayForBool .replaceObjectAtIndex(indexPath.section, withObject: collapsed)
            //reload specific section animated
            var range = NSMakeRange(indexPath.section, 1)
            var sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc : QuestionViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionView") as! QuestionViewController
        
        var key = categories?[indexPath.section].name
        var content = sectionContentDict .valueForKey(key!) as! NSArray
        if let faqQuestion = content .objectAtIndex(indexPath.row) as? FaqQuestion {
            vc.faqQuestion = faqQuestion;
            
        }
      
        self.showViewController(vc as QuestionViewController, sender: vc)

    //TODO redireci
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        let CellIdentifier = "Cell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell
        var manyCells : Bool = arrayForBool .objectAtIndex(indexPath.section).boolValue
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        if !manyCells {
             cell.textLabel?.text = "click to enlarge";
        } else {
            var key = categories?[indexPath.section].name
            var content = sectionContentDict .valueForKey(key!) as! NSArray
            if let faqQuestion = content .objectAtIndex(indexPath.row) as? FaqQuestion {
                cell.textLabel?.text = faqQuestion.question;

            }
            
        }
        return cell
    }
}

