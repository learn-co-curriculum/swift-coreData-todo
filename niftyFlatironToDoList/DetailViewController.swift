//
//  DetailViewController.swift
//  niftyFlatironToDoList
//
//  Created by Johann Kerr on 11/9/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController {
    
    //1 - this is a task shown in this detailViewController
    var task: Task!
    
    //2 -make an array of subtasks
    var subtaskArray:[Subtask] = []
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = task.content else { return }
        self.title = title
        
        self.subtaskArray = task.subtasks?.allObjects as! [Subtask]
        
        tableView.reloadData()
     
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtaskArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtaskCell")
        
        if let cellLabel = subtaskArray[indexPath.row].content {
            cell?.textLabel?.text = cellLabel
        }
        
        cell?.backgroundColor = UIColor.randomColor
        return cell!
    }
    
    
    @IBAction func composeBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Subtask", message: "Add a subtask to \(self.task.content)", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
            self.saveSubtask(titleString: nameToSave)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func saveSubtask(titleString:String){
       let managedContext = store.persistentContainer.viewContext
    
        var subtask = Subtask(context: managedContext)
        subtask.content = titleString
        self.task.addToSubtasks(subtask)
        self.subtaskArray.append(subtask)
        
        store.saveContext()
        
        //our "task" is sent from the viewController and set to our local "task" property and we can assign to it our "subtasks"(NSSet) relationship and it then creates an [anyObject] array of our subtasks
        task.subtasks?.allObjects
        
        
    }
    
    
    
}


