//
//  Helpers.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 5/1/22.
//

import UIKit

struct Utils {
    static func showAlert<T: UIViewController> (_ view: T, title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        view.present(alert, animated: true, completion: nil)
    }
}
