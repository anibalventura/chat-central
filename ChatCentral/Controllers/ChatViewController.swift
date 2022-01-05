//
//  ChatViewController.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 4/1/22.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var messages: [Message] = [
        Message(sender: "anibal@test.com", body: "Hey!"),
        Message(sender: "manuel@test.com", body: "Hello!"),
        Message(sender: "anibal@test.com", body: "💩"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.ChatTable.cellNibName, bundle: nil), forCellReuseIdentifier: K.ChatTable.cellIdentifier)
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOutUser()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
    private func logOutUser() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e as NSError {
            Utils.showAlert(self, title: "There was an error!", message: e.localizedDescription)
        }
    }
}

// MARK: - UITableView Data Source
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ChatTable.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = self.messages[indexPath.row].body
        return cell;
    }
}
