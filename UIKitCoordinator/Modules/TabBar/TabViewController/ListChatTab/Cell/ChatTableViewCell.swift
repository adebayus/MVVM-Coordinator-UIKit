//
//  ChatTableViewCell.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 20/12/24.
//

import UIKit

struct ChatTableViewCellModel {
    var type: TypeRoundedProfileView
    var username: String
    var isBlocked: Bool
    var statusChat: RoomStatusType
    var lateMessageDate: String
    var lastMessage: String
    var companyName: String
    var unreadChat: Int
}

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileView: RoundedProfileView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMessageDate: UILabel!
    @IBOutlet weak var unreadLabel: UILabel!
    @IBOutlet weak var containerUnreadView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerUnreadView.layer.cornerRadius =  containerUnreadView.layer.bounds.height / CGFloat(2)
        print(containerUnreadView.frame.height, containerUnreadView.frame.height / CGFloat(2))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal
    func configure(data: ChatTableViewCellModel) {
        
        profileView.type = data.type
        profileView.fullname = data.username
        profileView.isBlocked = data.isBlocked
        profileView.status = data.statusChat
        
        usernameLabel.text = data.username
        companyNameLabel.text = data.companyName
        lastMessageLabel.text = data.lastMessage
        lastMessageDate.text = data.lateMessageDate
        unreadLabel.text = String(data.unreadChat)
    }
    
}
