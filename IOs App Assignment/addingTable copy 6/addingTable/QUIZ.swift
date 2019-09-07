//
//  QUIZ.swift
//  addingTable
//
//  Created by Piotr Suchozebrski on 20/11/2018.
//  Copyright © 2018 Piotr Suchozebrski. All rights reserved.
//

import UIKit

class QUIZ: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var OurScoce: UILabel!
    var score = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var chances: UILabel!
    var chance = 0
    
    @IBOutlet weak var textField: UITextField!
    
   
    @IBOutlet weak var Check: UIButton!
   
    
        var myList: [ItemList] = [ItemList(translation:"", itemDescription:"")]
        
    
    @IBAction func info(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "Check your knolwedge by trying to translate the words from your notes.If you don't want to try again you will be give another word", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           
            
        }))
        
        
        self.present(alert, animated: true)
        
    }
    
   
        var storeName = "notesik.json"
        
        override func viewDidLoad() {
            super.viewDidLoad()
           
         
            label.isHidden = false
            Check.isHidden = false
            
            func setTitle(_ title : String?, for state : UIControl.State)   {
                
            }
            
            if fileExistsInDocuments(storeName) {
                loadPosition()
            } else {
                savePosition()
            }
            
            if let ItemList = myList.randomElement() {
                label.text = (ItemList.translation)
                labelTwo.text = (ItemList.itemDescription)

            }
            
           
            func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
                self.view.endEditing(true)
            }
            
            
            func textFieldShouldReturn(_ textField: UITextField) -> Bool
            { textField.resignFirstResponder()
                
                return true }
            
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
            
            
            
            
    }
        // Do any additional setup after loading the view.
    
        
    @IBAction func check(_ sender: Any) {
        
       
    
        chance += 1
        chances.text = "\(String(chance))"
        
        if chances.text == "6"{
          
            chances.text = "5"
    
            label.isHidden = true
            
            
            let alert = UIAlertController(title: "YOUR RESULT", message: "Score:\(String(score))", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "back", sender: nil)
                
            }))
            
            
            self.present(alert, animated: true)
            
        }
        
        
        if let ItemList = myList.randomElement() {
            label.text = ItemList.translation
            labelTwo.text = ItemList.itemDescription
            
              //  var array = [String]()
              //  var array2 = ["Pidlu", "mardlu"]
                
              //  array.append(contentsOf: array2)
              //  print(array)
            
            
        }
        label.isHidden = true
        Check.isHidden = false
    }
    @IBAction func randoms(_ sender: Any) {
       
        
        
        chance += 1
        chances.text = "\(String(chance))"
        Check.isHidden = false
        if chances.text == "6"{
            chances.text = "5"
        Check.isHidden = true
            label.isHidden = true
            Check.setTitle("Check",for: .normal)
        
        let alert = UIAlertController(title: "YOUR RESULT", message: "Score:\(String(score))", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "back", sender: nil)
            
        }))
        
        
        self.present(alert, animated: true)
        
        }
        
        if textField.text!==labelTwo.text{
            
            if chances.text == "7" {
                
                
                
                let alert = UIAlertController(title: "YOUR RESULT", message: "Score:\(String(score))", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "back", sender: nil)
               
                }))
                
                
                self.present(alert, animated: true)
                
                
            }
            score += 1
            OurScoce.text = "Score:\(String(score))"
     
            if let ItemList = myList.randomElement() {
                label.text = ItemList.translation
                labelTwo.text = ItemList.itemDescription
                
            }
            
           
            
            let alert = UIAlertController(title: "✓", message: "Correct Answre", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            
            let when = DispatchTime.now() + 0.6
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
            }
            textField.text = ""
            
        }
        else{
           
            
            
            let alert = UIAlertController(title: ":(", message: "Wrong Answere", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            
            let when = DispatchTime.now() + 1.5
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
                
                
                
                if let ItemList = self.myList.randomElement() {
                    self.label.text = ItemList.translation
                    self.labelTwo.text = ItemList.itemDescription}
            }
            
            textField.text = ""
            
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
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        self.view.endEditing(true)
    }
}
