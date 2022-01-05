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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger typing animation.
        appNameLabel.text = K.appName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
