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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger typing animation.
        appNameLabel.text = "💬 Chat Central"
    }
}
