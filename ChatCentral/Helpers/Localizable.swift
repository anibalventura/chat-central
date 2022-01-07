//
//  Localizable.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 6/1/22.
//

import Foundation

struct Localizable {
    struct Alert {
        static let confirm: String = NSLocalizedString("alert-confirm", comment: "")
    }

    struct Error {
        static let title: String = NSLocalizedString("error-title", comment: "")
    }

    /* Screens */

    struct Welcome {
        static let loginAlertTitle: String = NSLocalizedString("login-alert-title", comment: "")
        static let loginAlertMsg: String = NSLocalizedString("login-alert-message", comment: "")
    }

    struct Register {
        static let passwordAlertTitle: String = NSLocalizedString("password-alert-title", comment: "")
        static let passwordAlertMsg: String = NSLocalizedString("password-alert-message", comment: "")
    }
}
