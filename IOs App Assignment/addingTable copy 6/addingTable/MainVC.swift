//
//  MainVC.swift
//  addingTable
//
//  Created by Piotr Suchozebrski on 16/11/2018.
//  Copyright © 2018 Piotr Suchozebrski. All rights reserved.
//

import UIKit
import CoreData


class MainVC: UIViewController {

    @IBOutlet var settingsButton: [UIButton]!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var checkYourself: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var translator: UIButton!
    @IBOutlet weak var Notes: UIButton!
    @IBOutlet weak var changeLanguage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.value(forKey:  "name"), let language = UserDefaults.standard.value(forKey:  "language") {
            
            welcomeLabel.text = " \(name)"
            
            secondLabel.text = " \(language)"    }
        
        
        Notes.layer.cornerRadius = 7
        checkYourself.layer.cornerRadius = 7
        translator.layer.cornerRadius = 7
         settings.layer.cornerRadius = 7
        changeLanguage.layer.cornerRadius = 7
        
        
}
    
    
    @IBAction func newLanguage(_ sender: Any) {
        
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to start new language?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            
            self.performSegue(withIdentifier: "new", sender: UIButton())
            
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
    
    
    @IBAction func handleSelection(_ sender: UIButton) {
        
        
        
        settingsButton.forEach { (button) in
            UIView.animate(withDuration: 2, animations: {
                
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        
        }
        
        
        
        
    }
    
    
    @IBAction func translator(_ sender: UIButton)
    {
        
        
        if let url = NSURL(string: "https://translate.google.com/?hl=en") {
            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
    }
        
        
    
    
    
    
}
