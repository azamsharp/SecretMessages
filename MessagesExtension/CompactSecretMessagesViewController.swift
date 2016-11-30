//
//  CompactSecretMessagesViewController.swift
//  SecretMessages
//
//  Created by Mohammad Azam on 11/28/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

protocol CompactSecretMessagesDelegate : class {
    
    func compactSecretMessagesDidCreateMessageButtonPressed()
}

class CompactSecretMessagesViewController : UIViewController {
    
    weak var delegate :CompactSecretMessagesDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createMessageButtonPressed() {
        self.delegate.compactSecretMessagesDidCreateMessageButtonPressed()
    }
    
}

