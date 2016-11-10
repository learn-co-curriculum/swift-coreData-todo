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
    
    //3
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = task.content else { return }
        self.title = title
        
        //4 - set your subtaskArray to values in your coreData cast as an array of Subtasks
        //our "task" is sent from the viewController and set to our local "task" property and we can assign to it our "subtasks"(NSSet) relationship and it then creates an [anyObject] array of our subtasks
        self.subtaskArray = task.subtasks?.allObjects as! [Subtask]
        
        //5 - reload your table data to reflect your updated array
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
    
    //6 - function that saves subtasks from alertController text
    func saveSubtask(titleString:String){
        
        //7 - create a managedContext (file cabinet)
       let managedContext = store.persistentContainer.viewContext
    
        //8 - create a new subtask in our coreData
        var subtask = Subtask(context: managedContext)
        
        //9 - assign the content of his new subtask to the alertController text
        subtask.content = titleString
        
        //10 - add this subtask to our task w/ ".addToSubtasks"
        self.task.addToSubtasks(subtask)
        
        //11 - save our new subtask data
        store.saveContext()
        
        //12 - make sure this new subtask is added to our local subtaskArray
        self.subtaskArray.append(subtask)
        
    }
    
    
    
}


