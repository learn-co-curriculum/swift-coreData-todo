//
//  ViewController.swift
//  niftyFlatironToDoList
//
//  Created by Johann Kerr on 11/7/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit
import Foundation
import CoreData
class ViewController: UITableViewController {
    
    var todos = [Task]()
    
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("running")
        fetchData()
        self.tableView.reloadData()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! DetailViewController
        
        guard let indexPath = self.tableView.indexPathForSelectedRow?.row else{ return }
        
        //pass the right task w/ the array detail
        dest.task = todos[indexPath]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.backgroundColor = UIColor.randomColor
        
        if let unwrappedTitle = self.todos[indexPath.row].content {
            cell?.textLabel?.text = unwrappedTitle
        }
        
        
        return cell!
    }
    
    
    func fetchData(){
        
        let managedContext = store.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do{
            
            self.todos = try managedContext.fetch(fetchRequest)
            print(todos.count)
            self.tableView.reloadData()
            
        }catch{
            
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Todo", message: "Add Todo", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
            
            
            self.saveTodo(titleString: nameToSave)
            //self.todos.append(nameToSave)
            
            
            
            
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func saveTodo(titleString:String){
        let managedContext = store.persistentContainer.viewContext
        
        let
        todo = Task(context: managedContext)
        print(titleString)
        todo.content = titleString
        todo.createdAt = NSDate()
        
        do {
            try managedContext.save()
            self.todos.append(todo)
        }catch{
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
}


extension UIColor{
    
    class var randomColor: UIColor{
        get {
            let red = CGFloat(drand48())
            let green = CGFloat(drand48())
            let blue = CGFloat(drand48())
            return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
            
        }
    }
    
}

