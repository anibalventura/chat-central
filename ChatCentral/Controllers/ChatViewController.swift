//
//  ChatViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "💬 \(K.appName)"
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.ChatCell.cellNibName, bundle: nil), forCellReuseIdentifier: K.ChatCell.cellIdentifier)
        
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
            try Firebase.auth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e as NSError {
            Utils.showAlert(self, title: Localizable.Error.title, message: e.localizedDescription)
        }
    }
    
    // MARK: - Load/Send Message
    private func sendMessage() {
        let messageSender = Firebase.auth.currentUser?.email ?? ""
        let messageBody = messageTextField.text ?? ""
        
        if !messageSender.isEmpty && !messageBody.isEmpty {
            Firebase.fstore.collection(K.FStore.messagesCollection).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    Utils.showAlert(self, title: Localizable.Error.title, message: e.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    private func loadMessages() {
        Firebase.fstore.collection(K.FStore.messagesCollection).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            // Empty messages to add new messages on listener.
            self.messages = []
            
            if let e = error {
                Utils.showAlert(self, title: Localizable.Error.title, message: e.localizedDescription)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ChatCell.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        // Message from the current user.
        if message.sender == Firebase.auth.currentUser?.email {
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
