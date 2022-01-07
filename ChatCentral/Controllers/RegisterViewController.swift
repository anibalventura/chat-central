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
                Firebase.auth.createUser(withEmail: email, password: password) { _, error in
                    if let error = error {
                        Utils.showAlert(self, title: Localizable.Error.title, message: error.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: Consts.Segues.register, sender: self)
                    }
                }
            } else {
                Utils.showAlert(
                    self,
                    title: Localizable.Register.passwordAlertTitle,
                    message: Localizable.Register.passwordAlertMsg
                )
            }
        } else {
            Utils.showAlert(
                self,
                title: Localizable.Welcome.loginAlertTitle,
                message: Localizable.Welcome.loginAlertMsg
            )
        }
    }
}
