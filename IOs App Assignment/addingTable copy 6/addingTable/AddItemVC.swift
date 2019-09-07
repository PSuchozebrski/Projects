//
//  AddItemVC.swift
//  addingTable
//
//  Created by Piotr Suchozebrski on 15/11/2018.
//  Copyright © 2018 Piotr Suchozebrski. All rights reserved.
//

import UIKit
import CoreData

class AddItemVC: UIViewController, UITextFieldDelegate{

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        word.returnKeyType = UIReturnKeyType.done
       itemDescription.returnKeyType = UIReturnKeyType.done
        
         view.setGradientBackground(colorOne: Colors.brightOrange , colorTwo: Colors.Orange)
        
        word.text = String (translation)
        
        itemDescription.text = String(myDescription)
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var word: UITextField!
    
    @IBOutlet weak var itemDescription: UITextField!

    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    var item: ItemList?
    
    
    
    
    
    var translation: String = ""
    var myDescription: String = ""

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if textField == word{
            word.keyboardType = .default
        }else{
            itemDescription.keyboardType = .default
        }
        
        return true
    }
    func textShouldReturn(_ textField: UITextField) -> Bool{
        word.resignFirstResponder()
        itemDescription.resignFirstResponder()
        if textField == word {
            itemDescription.becomeFirstResponder()
            
        }else{
            word.becomeFirstResponder()
       
        
        
        }
        
        
        
        
        
        return true
    
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        
        if word.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Problem!", message: "Pleae type a word", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            
        }else{
            if itemDescription.text?.isEmpty ?? true {
                let alert = UIAlertController(title: "Problem!", message: "Pleae type a word", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true)
            }else{
                
                if let meaning = word.text{
                    if let description = itemDescription.text{
                        item = ItemList(translation: meaning, itemDescription: description)
                    }
                    
                }
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    { word.resignFirstResponder()
        itemDescription.resignFirstResponder()
        
        return true }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        self.view.endEditing(true)
    }
}
 



 
