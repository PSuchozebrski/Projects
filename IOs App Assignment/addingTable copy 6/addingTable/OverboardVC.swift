//
//  OverboardVC.swift
//  addingTable
//
//  Created by Piotr Suchozebrski on 16/11/2018.
//  Copyright © 2018 Piotr Suchozebrski. All rights reserved.
//

import UIKit
import CoreData



class OverboardVC: UIViewController,UITextFieldDelegate, UITableViewDelegate {

    

    
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    
    
    
     var myList: [ItemList] = [ItemList(translation:"", itemDescription:"")]

    
    
     var storeName = "notesik.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if fileExistsInDocuments(storeName) {
            loadPosition()
        } else {
            savePosition()
        }
    
    

    
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
        
    
       
        textFieldOne.returnKeyType = UIReturnKeyType.done
        textFieldTwo.returnKeyType = UIReturnKeyType.done
        
       

        view.setGradientBackground(colorOne: Colors.brightOrange , colorTwo: Colors.Orange)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func continueTouched(_ sender: Any) {
       
        if fileExistsInDocuments(storeName) {
            loadPosition()
        } else {
            savePosition()
        }

        
        self.myList.removeAll()
        self.savePosition()
    
        
     
   
        UserDefaults.standard.set(textFieldOne.text, forKey: "name")
        
        if textFieldTwo.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Problem!", message: "Pleae type a language you Learn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
        }
        
        
        UserDefaults.standard.set(textFieldTwo.text, forKey: "language")
        
        if textFieldOne.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Problem!", message: "Pleae type a language you Learn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
        }
        
        

        
        performSegue(withIdentifier: "toMainSegue", sender: self)
        
    }
    
    // Do any additional setup after loading the view.
    
    



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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    { textFieldOne.resignFirstResponder()
       textFieldTwo.resignFirstResponder()
        
        return true }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        self.view.endEditing(true)
    }

}
