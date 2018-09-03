//
//  Category.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 9/3/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
