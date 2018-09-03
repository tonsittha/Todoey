//
//  Item.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 9/3/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var isChecked : Bool = false
    @objc dynamic var dateCreated : Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
