//
//  LoginViewController.swift
//  radioChat
//
//  Created by elliott on 3/18/21.
//

import UIKit
import Firebase
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    let keychain = Keychain(service: "com.ecgriffin.radioChat")
                    keychain["email"] = email
                    keychain["password"] = password
                    
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = Keychain(service: "com.ecgriffin.radioChat")
        self.emailText.text = keychain["email"]
        self.passwordText.text = keychain["password"]
        
    }
    
}
