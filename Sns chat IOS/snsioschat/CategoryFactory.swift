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
                return Category(id: id, name: name)
            }
        }
        
        return nil
    }
}
