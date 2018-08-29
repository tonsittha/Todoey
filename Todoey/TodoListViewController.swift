//
//  ViewController.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/29/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todoArray = ["Buy eggs", "Buy Milk", "Sleep"]
    
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
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
    }

    
    //MARK: - Add new items
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textfield.text != "" {
                self.todoArray.append(textfield.text!)
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "New item"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

