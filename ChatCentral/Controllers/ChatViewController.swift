//
//  ChatViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    private let db = Firestore.firestore()
    private var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.ChatTable.cellNibName, bundle: nil), forCellReuseIdentifier: K.ChatTable.cellIdentifier)
        
        loadMessages()
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOutUser()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        sendMessage()
    }
    
    private func logOutUser() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e as NSError {
            Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
        }
    }
    
    private func sendMessage() {
        let messageSender = Auth.auth().currentUser?.email ?? ""
        let messageBody = messageTextField.text ?? ""
        
        if !messageSender.isEmpty && !messageBody.isEmpty {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            // Empty messages to add new messages on listener.
            self.messages = []
            
            if let e = error {
                Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let messageSender = data[K.FStore.senderField] as? String ?? ""
                    let messageBody = data[K.FStore.bodyField] as? String ?? ""
                    
                    if !messageSender.isEmpty && !messageBody.isEmpty {
                        self.messages.append(
                            Message(sender: messageSender,body: messageBody)
                        )
                    }
                }
                
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
    }
}

// MARK: - UITableView Data Source
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ChatTable.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        // Message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftAvatarImage.isHidden = true
            cell.rightAvatarImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.navy)
            cell.messageLabel.textColor = UIColor(named: K.Colors.orange)
        }
        // Message from another sender.
        else {
            cell.leftAvatarImage.isHidden = false
            cell.rightAvatarImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.orange)
            cell.messageLabel.textColor = UIColor(named: K.Colors.navy)
        }
        
        return cell
    }
}
