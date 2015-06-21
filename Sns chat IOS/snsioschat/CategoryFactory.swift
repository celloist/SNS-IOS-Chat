//
//  CategoryFactory.swift
//  Sns chat IOS
//
//  Created by Mark Jan Kamminga on 09-04-15.
//  Copyright (c) 2015 Mark Jan Kamminga. All rights reserved.
//

import Foundation

class CategoryFactory: NSObject {
    func createCategoryFromJson (data: AnyObject) -> Category? {
        if let id = data["_id"] as? String {
            if let name = data["name"] as? String {
                //println(id + " name " + name)
                return Category(id: id, name: name)
            }
        }
        
        return nil
    }
    
    func createCategoriesFromJson (data: AnyObject) -> [Category]? {
        var categories = [Category]()
        
        if let payload  = data as? NSArray {
            for rawItem in payload {
                println("categorie ")
                categories.append(createCategoryFromJson(rawItem)!)
            }
        }
        return categories
    }
}
