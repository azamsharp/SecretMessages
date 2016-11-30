//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Mohammad Azam on 11/28/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, CompactSecretMessagesDelegate, CreateSecretMessageDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createSecretMessageDidSendMessage(text: String) {
        
        requestPresentationStyle(.compact)
        
        let components = NSURLComponents()
        components.queryItems = [URLQueryItem(name: "SecretKey", value: text)]
        
        let message = MSMessage()
        message.url = components.url!
        
        // Query String 
        // Key=Value&Key2=Value&Key3=Value
        
        // SecretKey=Hey want to go for a party?
        
        let layout = MSMessageTemplateLayout()
        layout.image = UIImage(named: "topsecret")
        
        message.layout = layout
        
        self.activeConversation?.insert(message, completionHandler: nil)
    }
    
    func compactSecretMessagesDidCreateMessageButtonPressed() {
        requestPresentationStyle(.expanded)
    }
    
    override func didBecomeActive(with conversation: MSConversation) {
        
        presentViewController(for: conversation, for: presentationStyle)
        
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        
        guard let conversation = self.activeConversation else {
            fatalError("No active conversation found")
        }
        
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    func presentViewController(for conversation: MSConversation, for presentationStyle :MSMessagesAppPresentationStyle) {
        
        var controller :UIViewController!
        
        if presentationStyle == .compact {
            controller = instantiateCompactSecretMessagesViewController()
        } else {
            
            if conversation.selectedMessage != nil {
                
                guard let message = conversation.selectedMessage,
                      let url = message.url,
                      let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false),
                      let queryItems = components.queryItems,
                      let text = queryItems[0].value
                
                else {
                    fatalError("No Message Selected")
                }
                
               controller = instantiateCreateSecretMessageViewController(secretMessage :text)
                
            } else {
                  controller = instantiateCreateSecretMessageViewController()
            }
            
            
            
        }
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        addChildViewController(controller)
        
        controller.view.frame = self.view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateCompactSecretMessagesViewController() -> UIViewController {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CompactSecretMessagesViewController") as? CompactSecretMessagesViewController else {
            fatalError("CompactSecretMessagesViewController not found")
        }
        
        controller.delegate = self
        
        return controller
    }
    
    private func instantiateCreateSecretMessageViewController(secretMessage :String) -> UIViewController {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateSecretMessageViewController") as? CreateSecretMessageViewController else {
            fatalError("CreateSecretMessageViewController not found")
        }
        
        controller.delegate = self
        controller.secretMessage = secretMessage
        
        return controller
    }
    
    private func instantiateCreateSecretMessageViewController() -> UIViewController {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateSecretMessageViewController") as? CreateSecretMessageViewController else {
            fatalError("CreateSecretMessageViewController not found")
        }
        
        controller.delegate = self
        
        return controller
    }

   
}
