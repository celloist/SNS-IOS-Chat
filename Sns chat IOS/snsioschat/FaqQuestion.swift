//
//  FaqQuestion.swift
//  Sns chat IOS
//
//  Created by User on 02/06/15.
//  Copyright (c) 2015 nl.avans.aii.IIINMBD. All rights reserved.
//

import Foundation

class FaqQuestion{
    let answer: String
    let question : String
    let id: String
    let category: Category
    
    init(anwser: String, question: String, id: String, category:Category){
        self.answer = anwser
        self.question = question
        self.id = id
        self.category = category;
    }
}