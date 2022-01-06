//
//  Localizable.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 6/1/22.
//

import Foundation

struct Localizable {
    struct Alert {
        static let confirm: String = NSLocalizedString("alert-confirm", comment: "Confirm alert.")
    }
    
    struct Error {
        static let title: String = NSLocalizedString("error-title", comment: "Title of generic error.")
    }
    
    /* Screens */
    
    struct Welcome {
        static let loginAlertTitle: String = NSLocalizedString("login-alert-title", comment: "Alert title when login fields are incomplete.")
        static let loginAlertMsg: String = NSLocalizedString("login-alert-message", comment: "Must complete all fields to continue.")
    }
    
    struct Register {
        static let passwordAlertTitle: String = NSLocalizedString("password-alert-title", comment: "Alert title when passwords are not the same.")
        static let passwordAlertMsg: String = NSLocalizedString("password-alert-message", comment: "Alert message when passwords are not the same.")
    }
}
