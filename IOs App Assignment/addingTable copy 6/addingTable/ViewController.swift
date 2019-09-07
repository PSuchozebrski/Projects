//
//  ViewController.swift
//  addingTable
//
//  Created by Piotr Suchozebrski on 15/11/2018.
//  Copyright © 2018 Piotr Suchozebrski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    
    @IBOutlet weak var tableViewList: UITableView!
    
    
    
    var myList: [ItemList] = [ItemList(translation:"", itemDescription:"")]
    
   
    
    @IBAction func deletes(_ sender: Any) {
    
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete all the words?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            
            self.myList.removeAll()
            self.savePosition()
            self.tableViewList.reloadData()
           
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    
    
    var storeName = "notesik.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        // If no notes stored, create a new store with default myNotes
        if fileExistsInDocuments(storeName) {
            loadPosition()
        } else {
            savePosition()
        }
    }

    func tableView(_ tableView:UITableView,numberOfRowsInSection section: Int) -> Int{
    return myList.count
    }
    
    
        
        func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier: "prototype", for: indexPath) as! PrototypeCell
            let itemsInCell = myList[indexPath.row]
   // cell.textLabel?.text = list[indexPath.row]
            
            
            cell.itemDescription.text = itemsInCell.itemDescription
            
            cell.translation.text = itemsInCell.translation
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
         myList.remove(at: indexPath.row)
             savePosition()
            tableViewList.reloadData()
            
        }
    }
    
    
    @IBAction func unWindToList(sender:UIStoryboardSegue){
        
        
        if let sourceViewController = sender.source as? AddItemVC,
            let item = sourceViewController.item{
        
            
            
            let newIndexPath = IndexPath(row: myList.count,  section: 0)
            myList.append(item)
            savePosition()
            tableViewList.insertRows(at: [newIndexPath], with: .automatic)
            
            
            
           
            
            
        }
        
        
       
        }
    
    
    
    func loadPosition(){
        // Either load last unit practised, or if starting then remember unit 1
        let settingsURL =  urlToFileInDocuments(storeName)
        if let dataFromFile = try? Data(contentsOf: settingsURL) {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode(Array<ItemList>.self, from: dataFromFile) {
                myList = loadedNotes
            }
        }
    }
    
    func savePosition(){
        // Saves where we are in the bible to disk
        let settingsURL =  urlToFileInDocuments(storeName)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(myList){
            //Write the data to backing store.
            try? data.write(to: settingsURL, options: .noFileProtection)
        }
    }
    
    func fileExistsInDocuments( _ fileName: String ) -> Bool {
        let fileManager = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let filepathName = docsDir + "/\(fileName)"
        return fileManager.fileExists(atPath: filepathName)
    }
    
    func urlToFileInDocuments( _ fileName: String ) -> URL {
        let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filesURL = docDirectory.appendingPathComponent(fileName)
       
        print(filesURL)
        
        return filesURL
        
        
    }
    }
    






class PrototypeCell: UITableViewCell{
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var translation: UILabel!
}







