//
//  ViewController.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/29/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    let realm = try! Realm()

    var todoItems : Results<Item>?
    
    var category : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.name
            cell.accessoryType = item.isChecked ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No item added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    
    //MARK: - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedItem = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    selectedItem.isChecked = !selectedItem.isChecked
                }
            } catch {
                print("error updating data \(error)")
            }
        }
        
        tableView.reloadData()
    }

    
    //MARK: - Add new items
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textfield.text != "" {

                if let currentCategory = self.category {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.name = textfield.text!
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving data: \(error)")
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "New item"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Database functions
    
    func loadItems() {

        todoItems = category?.items.sorted(byKeyPath: "name", ascending: true)

        tableView.reloadData()
    }
    
}


//MARK: - Searchbar functions

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

