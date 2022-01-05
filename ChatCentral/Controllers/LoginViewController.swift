//
//  LoginViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginUser()
    }
    
    private func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.Segues.login, sender: self)
                }
            }
        } else {
            Utils.showAlert(self, title: "Complete fields!", message: "Must complete all fields to continue.")
        }
    }
}
