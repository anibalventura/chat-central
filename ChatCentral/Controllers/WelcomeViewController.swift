//
//  WelcomeViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBOutlet weak var appNameLabel: CLTypingLabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Trigger typing animation.
        appNameLabel.text = Consts.appName
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
                    Utils.showAlert(self, title: Localizable.Error.title, message: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: Consts.Segues.welcome, sender: self)
                }
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
