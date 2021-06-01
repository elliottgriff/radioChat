//
//  GroupSelectViewController.swift
//  radioChat
//
//  Created by elliott on 4/6/21.
//

import Foundation
import Firebase

class GroupSelectViewController: UIViewController {
    
    @IBOutlet weak var roomName: UITextField!
    @IBOutlet weak var newRoomName: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func enterRoomPressed(_ sender: UIButton) {
        
        
        if let room = roomName.text {
            
            db.collectionGroup(room).getDocuments { (snapshot, error) in
                if let e = error {
                    
                    let alert = UIAlertController(title: "", message: "please enter room name", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    print("error \(e)")
                    
                } else {
                    
                    if let docsCount = snapshot?.documents.count {
                        
                        if docsCount > 0 {
                            K.Fstore.roomName = room
                            self.performSegue(withIdentifier: K.groupSegue, sender: self)
                        } else {
                            let alert = UIAlertController(title: "", message: "room does not exist", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        print(docsCount)
                        
                        print("no error")
                    
                }
            }
            }
        }
    }
            
//            let existingRoom = db.collection(room).collectionID
//            print(existingRoom)
            
//            if db.collection(room).collectionID.isEmpty {
//
//                print("room doesnt exist")
////
//            } else {
////
//                print("room exists")
////                print("collection id \(db.collection(room).collectionID)")
////                K.Fstore.roomName = room
////                self.performSegue(withIdentifier: K.groupSegue, sender: self)
////
//            }
//        }
//    }
    
    @IBAction func newRoomPressed(_ sender: UIButton) {
        
        if let room = newRoomName.text {
            db.collectionGroup(room).getDocuments { (snapshot, error) in
                if let e = error {
                    let alert = UIAlertController(title: "", message: "choose a name", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print("error \(e)")
                } else {
                    if let docsCount = snapshot?.documents.count {
                        if docsCount < 1 {
                            K.Fstore.roomName = room
                            self.performSegue(withIdentifier: K.groupSegue, sender: self)
                        } else {
                            let alert = UIAlertController(title: "", message: "room already exists", preferredStyle: .actionSheet)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
}
