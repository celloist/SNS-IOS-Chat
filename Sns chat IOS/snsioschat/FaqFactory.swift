//
//  FaqFactory.swift
//  Sns chat IOS
//
//  Created by User on 02/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class FaqFactory: NSObject {
    func createQuestionsFromJson (data: AnyObject) -> [FaqQuestion] {
        var faqQuestion = [FaqQuestion]()

        if let payload  = data as? NSArray {
            for rawItem in payload {
                faqQuestion.append(createQuestionFromJson(rawItem)!)
            }
        }

       
        
        return faqQuestion
    }
    func createQuestionFromJson(data: AnyObject) -> FaqQuestion?{
        if let answer = data["answer"] as? String {
            if let question = data["question"] as? String {
                if let id = data["_id"] as? String{
                    if let category: AnyObject? = data["category"]{
                        var categoryFactory = CategoryFactory();
                        if let category = categoryFactory.createCategoryFromJson(category!){
                            return FaqQuestion(anwser: answer, question: question, id: id, category:category);
                        }
                    }
                }
            }
        }
        return nil
    }
}
