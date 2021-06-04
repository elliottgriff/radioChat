//
//  ChatViewController.swift
//  radioChat
//
//  Created by elliott on 3/18/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatSendingText: UITextView!
    
    let db = Firestore.firestore()
    let groupSelectVC = GroupSelectViewController()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = K.Fstore.roomName
        
        chatSendingText.sizeToFit()
        
        chatTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        chatTableView.register(UINib(nibName: K.otherCellNibName, bundle: nil), forCellReuseIdentifier: K.otherCellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        db.collection(K.Fstore.roomName)
            .order(by: K.Fstore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let e = error {
                print("issue retrieving firestore shit \(e)")
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                        if let messageSender = data[K.Fstore.senderField] as? String,
                           let messageBody = data[K.Fstore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = chatSendingText.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.Fstore.roomName).addDocument(data: [
                K.Fstore.senderField: messageSender,
                K.Fstore.bodyField: messageBody,
                K.Fstore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("couldnt send message firestore \(e)")
                } else {
                    print("successfully sent message")
                    DispatchQueue.main.async {
                        self.chatSendingText.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func leaveActionPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let e as NSError {
            print("error signing out \(e)")
            let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .actionSheet)
            alert.addAction((UIAlertAction(title: "OK", style: .cancel, handler: nil)))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let yourCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let otherCell = tableView.dequeueReusableCell(withIdentifier: K.otherCellIdentifier, for: indexPath) as! OtherUserCell
                
        if message.sender == Auth.auth().currentUser?.email {
            
            yourCell.textView.text = message.body
    
            let name = message.sender
            let atSign = name.firstIndex(of: "@") ?? name.endIndex
            let firstName = name[..<atSign]
            yourCell.yourUserLabel.text = String(firstName)
            
            return yourCell
            
        } else {
            
            otherCell.otherText.text = message.body
    
            let name = message.sender
            let atSign = name.firstIndex(of: "@") ?? name.endIndex
            let firstName = name[..<atSign]
            otherCell.otherUserLabel.text = String(firstName)
            
            return otherCell
            
        }
    }
}
