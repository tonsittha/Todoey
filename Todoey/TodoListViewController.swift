//
//  ViewController.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/29/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let todoArray = ["Buy eggs", "Buy Milk", "Sleep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoArray.count
    }
    
    
    //MARK: - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = todoArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
    }

}

