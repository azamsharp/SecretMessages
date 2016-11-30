//
//  CreateSecretMessageViewController.swift
//  SecretMessages
//
//  Created by Mohammad Azam on 11/28/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

protocol CreateSecretMessageDelegate : class {
    func createSecretMessageDidSendMessage(text :String)
}

class CreateSecretMessageViewController : UIViewController {
    
    var secretMessage :String! 
    
    weak var delegate : CreateSecretMessageDelegate!
    
    @IBOutlet weak var secretMessageTextField :UITextField!
    @IBOutlet weak var secretMessageLabel :UILabel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secretMessageLabel.text = self.secretMessage
    }
    
    @IBAction func sendButtonPressed() {
        
        self.delegate.createSecretMessageDidSendMessage(text: self.secretMessageTextField.text!)
        
    }
}
