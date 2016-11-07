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
    
    
    var todos: [Lab] = []
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.backgroundColor = UIColor.randomColor
        cell?.textLabel?.text = todos[indexPath.row].name!
        return cell!
    }
    
    
    func fetchData(){
        let managedContext = store.persistentContainer.viewContext
        var fetchRequest = NSFetchRequest<Lab>(entityName: "Lab")
        do{
            self.todos = try managedContext.fetch(fetchRequest)
        
            
        }catch{
            
        }
       
    }
    

    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Lab", message: "Add Topic and Name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
            
            let managedContext = self.store.persistentContainer.viewContext
            
            var entity = NSEntityDescription.entity(forEntityName: "Lab", in: managedContext)
            var task = NSManagedObject(entity: entity!, insertInto: managedContext) as! Lab
            task.name = nameToSave
            do {
                try managedContext.save()
                self.todos.append(task)
            }catch{
                
            }
            
            
            //self.labs.append(nameToSave)

            
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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

