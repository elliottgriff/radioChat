//
//  ViewController.swift
//  radioChat
//
//  Created by elliott on 2/4/21.
//

import UIKit
import KeychainAccess

class WelcomeViewController: UIViewController {

    let groupVC = GroupSelectViewController()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        let keychain = Keychain(service: "com.ecgriffin.radioChat")
        let email = try? keychain.get("email")
        let password = try? keychain.get("password")
        
        if (email != nil) && (password != nil) {
            self.performSegue(withIdentifier: K.welcomeSegue, sender: self)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
        
    }


}

