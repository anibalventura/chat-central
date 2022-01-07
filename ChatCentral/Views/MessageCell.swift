//
//  MessageCell.swift
//  ChatCentral
//
//  Created by Anibal Ventura on 5/1/22.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var leftAvatarImage: UIImageView!
    @IBOutlet weak var rightAvatarImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
