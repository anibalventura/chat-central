//
//  Helpers.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 5/1/22.
//

import UIKit

struct Utils {
    static func initiateViewController(_ identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier)
    }

    static func showAlert<T: UIViewController> (_ view: T, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.Alert.confirm, style: .default))
        view.present(alert, animated: true, completion: nil)
    }
}
