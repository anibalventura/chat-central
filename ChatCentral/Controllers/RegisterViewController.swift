//
//  RegisterViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        createUser()
    }
    
    private func createUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty {
            if password == confirmPassword {
                Firebase.auth.createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: K.Segues.register, sender: self)
                    }
                }
            } else {
                Utils.showAlert(self, title: "Different passwords!", message: "Passwords have to be the same.")
            }
        } else {
            Utils.showAlert(self, title: "Complete fields!", message: "Must complete all fields to continue.")
        }
    }
}
