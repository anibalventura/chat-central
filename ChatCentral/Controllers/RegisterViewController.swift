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
                        // Save last email login.
                        Prefs.set(value: self.emailTextField.text, key: Consts.Prefs.lastEmailLogin)

                        // Navigate to Main View Controller.
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                            .changeRootViewController(Utils.initiateViewController(Consts.NavController.main))
                    }
                }
            } else {
                Utils.showAlert(
                    self, title: Localizable.Register.passwordAlertTitle,
                    message: Localizable.Register.passwordAlertMsg
                )
            }
        } else {
            Utils.showAlert(
                self, title: Localizable.Login.loginAlertTitle,
                message: Localizable.Login.loginAlertMsg
            )
        }
    }
}
