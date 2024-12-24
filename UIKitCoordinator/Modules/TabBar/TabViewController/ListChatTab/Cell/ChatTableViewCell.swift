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
    var lateMessageDate: String?
    var lastMessage: String?
    var companyName: String
    var unreadChat: Int
}

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileView: RoundedProfileView!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMessageDate: UILabel!
    @IBOutlet weak var unreadLabel: UILabel!
    @IBOutlet weak var containerUnreadView: UIView!
    @IBOutlet weak var companyBadgeView: CompanyBadgeView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerUnreadView.layer.cornerRadius = containerUnreadView.layer.bounds.height / CGFloat(2)
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
        
        usernameLabel.text = data.username.capitalized
        lastMessageLabel.text = data.lastMessage ?? ""
        companyBadgeView.companyName = data.companyName
        
        if let timestamp = data.lateMessageDate  {
            lastMessageDate.text = dateChatFormatter(date: timestamp)
            lastMessageDate.isHidden = false
        } else {
            lastMessageDate.isHidden = true
        }
        
        if data.unreadChat > 0 {
            unreadLabel.text = String(data.unreadChat)
            unreadLabel.isHidden = false
            containerUnreadView.isHidden = false
        } else {
            containerUnreadView.isHidden = true
            unreadLabel.isHidden = true
        }
     
        contentView.layoutIfNeeded()
    }
    
    internal func dateChatFormatter(date: String) -> String {
        
        let chatDate = DateFormatter.utcToGmt7Date(date: date) ?? Date()
        
        let isToday = Date.isToday(date: chatDate)
        let isYesterday = Date.isYesterday(date: chatDate)
        let isInWeekAgo = Date.isInWeekAgo(date: chatDate)
        
        let df = DateFormatter.dateFormatter
        
        if isToday {
            df.dateFormat = "HH:mm"
        } else if isYesterday {
            return "Yesterday"
        } else if isInWeekAgo {
            df.dateFormat = "EEEE"
        } else {
            df.dateFormat = "dd/MM"
        }
    
        return df.string(from: chatDate)
    }

}
