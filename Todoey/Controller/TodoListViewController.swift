//
//  ViewController.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/29/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var todoArray = [Item]()
    var category : Category? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = todoArray[indexPath.row].name
        cell.accessoryType = todoArray[indexPath.row].isChecked ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoArray.count
    }
    
    
    //MARK: - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        todoArray[indexPath.row].isChecked = !todoArray[indexPath.row].isChecked
        
//        context.delete(todoArray[indexPath.row])
//        todoArray.remove(at: indexPath.row)
        
        saveItems()
    }

    
    //MARK: - Add new items
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textfield.text != "" {
                
                
                let newItem = Item(context: self.context)
                
                newItem.name = textfield.text!
                newItem.isChecked = false
                newItem.parentCategory = self.category
                self.todoArray.append(newItem)
                self.saveItems()
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
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        let categoryPredecate = NSPredicate(format: "parentCategory.name MATCHES %@", (category?.name)!)
        
        request.predicate = (predicate != nil) ? NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredecate, predicate!]) : categoryPredecate

        
        do {
            todoArray = try context.fetch(request)
        } catch {
            print("Error fetching request: \(error)")
        }
        
        tableView.reloadData()
    }
    
}


//MARK: - Searchbar functions

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
    
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
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

