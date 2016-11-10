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
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = task.content else { return }
        self.title = title
        
     
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtaskCell")
        
        
        
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
       
        
    }
    
    
    
}


