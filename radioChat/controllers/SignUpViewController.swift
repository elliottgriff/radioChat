//
//  SignUpViewController.swift
//  radioChat
//
//  Created by elliott on 3/18/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func enterPressed(_ sender: UIButton) {
        
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                           if let e = error {
                               print("this is the error \(e)")
                               let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .actionSheet)
                               alert.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
                               self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: K.signupSegue, sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
