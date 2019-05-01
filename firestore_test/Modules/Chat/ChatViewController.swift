//
//  ChatViewController.swift
//  firestore_test
//
//  Created by Takahiro Ishitsuka  on 2019/04/29.
//  Copyright © 2019 Taka. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var messages : [Message.Data] = []
    private var messageListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.messageListener = Firestore.firestore().collection( "chat" ).order( by: "date" ).addSnapshotListener { snapshot, e in
            if let snapshot = snapshot {
                
                self.messages = snapshot.documents.map{ message -> Message.Data in
                    let data = message.data()
                    return Message.Data(senderId: data["sender_id"] as! String, name: data["name"] as! String, message: data["text"] as! String)
                }
                self.chatTableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear( animated )
        if let mUnsubscribe = messageListener { mUnsubscribe.remove() }
    }
    
    @IBAction func trappedSendButton(_ sender: Any) {
        sendChatMessage(name: nameTextField.text ?? "", message: messageTextField.text ?? "")
    }
    
    private func sendChatMessage(name: String, message: String) {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else { return }
        
        let dataStore = Firestore.firestore()
        dataStore.collection("chat").addDocument(data: [
            "text": message,
            "name": name,
            "sender_id": id,
            "date": Date()
        ]) { err in
            DispatchQueue.main.async {
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
}

extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messages.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ChatTableViewCell",for: indexPath) as! ChatTableViewCell
        if let message = messages[safe: indexPath.row] {
            cell.set(name: message.name)
            cell.set(message: message.message)
        }
        return cell
    }
    
}
