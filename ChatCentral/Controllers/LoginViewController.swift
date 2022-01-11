//
//  WelcomeViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit
import CLTypingLabel

class LoginViewController: UIViewController {
    @IBOutlet weak var appNameLabel: CLTypingLabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Trigger typing animation.
        appNameLabel.text = Consts.appName

        if let lastEmailLogin = Prefs.get(type: String.self, forKey: Consts.Prefs.lastEmailLogin) {
            emailTextField.text = lastEmailLogin
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        loginUser()
    }

    private func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if !email.isEmpty && !password.isEmpty {
            Firebase.auth.signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    Utils.showAlert(
                        self, title: Localizable.Error.title,
                        message: error.localizedDescription
                    )
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
                self, title: Localizable.Login.loginAlertTitle,
                message: Localizable.Login.loginAlertMsg
            )
        }
    }
}
