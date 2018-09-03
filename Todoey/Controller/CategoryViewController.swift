//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sittha Sukkasi on 8/31/18.
//  Copyright © 2018 Sittha Sukkasi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No category added yet"
        
        return cell
    }
    
    
    
    //MARK: - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItems" && categoryArray != nil {
            let destinationVC = segue.destination as! TodoListViewController
            destinationVC.category = categoryArray?[(tableView.indexPathForSelectedRow?.row)!]
        }
    }


    
    //MARK: - Database functions
    
    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving data: \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
    }
    

    @IBAction func addCategoryPressed(_ sender: Any) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textfield.text != "" {
                
                let newCategory = Category( )
                newCategory.name = textfield.text!
                 
                self.save(category: newCategory)
            }
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "New Category"
            textfield = alerttextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
