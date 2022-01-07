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
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOutUser()
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        sendMessage()
    }

    private var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "💬 \(Consts.appName)"
        navigationItem.hidesBackButton = true

        tableView.dataSource = self
        tableView.register(
            UINib(nibName: Consts.ChatCell.cellNibName, bundle: nil),
            forCellReuseIdentifier: Consts.ChatCell.cellIdentifier
        )

        loadMessages()
    }

    private func logOutUser() {
        do {
            try Firebase.auth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            Utils.showAlert(self, title: Localizable.Error.title, message: error.localizedDescription)
        }
    }

    // MARK: - Load/Send Message
    private func sendMessage() {
        let messageSender = Firebase.auth.currentUser?.email ?? ""
        let messageBody = messageTextField.text ?? ""

        if !messageSender.isEmpty && !messageBody.isEmpty {
            Firebase.fstore.collection(Consts.FStore.messagesCollection).addDocument(data: [
                Consts.FStore.senderField: messageSender,
                Consts.FStore.bodyField: messageBody,
                Consts.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    Utils.showAlert(self, title: Localizable.Error.title, message: error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }

    private func loadMessages() {
        Firebase.fstore
            .collection(Consts.FStore.messagesCollection)
            .order(by: Consts.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in

            // Empty messages to add incoming messages from snapshot.
            self.messages = []

            if let error = error {
                Utils.showAlert(self, title: Localizable.Error.title, message: error.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let messageSender = data[Consts.FStore.senderField] as? String ?? ""
                    let messageBody = data[Consts.FStore.bodyField] as? String ?? ""

                    if !messageSender.isEmpty && !messageBody.isEmpty {
                        self.messages.append(
                            Message(sender: messageSender, body: messageBody)
                        )
                    }
                }

                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)

                    self.tableView.reloadData()
                    if !self.messages.isEmpty {
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Consts.ChatCell.cellIdentifier, for: indexPath
        ) as! MessageCell
        cell.messageLabel.text = message.body
        cell.senderLabel.text = message.sender

        // Message from the current user.
        if message.sender == Firebase.auth.currentUser?.email {
            cell.leftAvatarImage.isHidden = true
            cell.rightAvatarImage.isHidden = false
            cell.senderLabel.textAlignment = .right
            cell.messageLabel.textAlignment = .right
            cell.messageBubble.backgroundColor = UIColor(named: Consts.Colors.navy)
            cell.messageLabel.textColor = UIColor(named: Consts.Colors.orange)
        }
        // Message from another sender.
        else {
            cell.leftAvatarImage.isHidden = false
            cell.rightAvatarImage.isHidden = true
            cell.senderLabel.textAlignment = .left
            cell.messageLabel.textAlignment = .left
            cell.messageBubble.backgroundColor = UIColor(named: Consts.Colors.blue)
            cell.messageLabel.textColor = UIColor(named: Consts.Colors.orange)
        }

        return cell
    }
}
