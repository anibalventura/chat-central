//
//  Firebase.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 5/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Firebase {
    static let auth: Auth = Auth.auth()
    static let fstore: Firestore = Firestore.firestore()
}
