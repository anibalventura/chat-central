//
//  Constants.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 5/1/22.
//

struct K {
    static let appName: String = "Chat Central"
    
    struct Segues {
        static let register: String = "RegisterToChat"
        static let welcome: String = "WelcomeToChat"
    }
    
    struct ChatCell {
        static let cellIdentifier: String = "ReusableCell"
        static let cellNibName: String = "MessageCell"
    }
    
    struct Colors {
        static let blue: String = "Blue"
        static let navy: String = "Navy"
        static let orange: String = "Orange"
        static let purple: String = "Purple"
    }
    
    struct FStore {
        static let messagesCollection: String = "messages"
        static let senderField: String = "sender"
        static let bodyField: String = "body"
        static let dateField: String = "date"
    }
}
