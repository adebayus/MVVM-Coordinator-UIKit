//
//  HandledContactResponse.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 16/12/24.
//

import Foundation

struct HandledContactResponse: Codable {
    let contactPairingID: Int?
    let contactID: Int?
    let contactName: String?
    let isActive: Bool?
    let photoURL: String?
    let companyID: Int?
    let companyName: String?
    let isBlocked: Bool?
    let isNew: Bool?
    let channelID: ChannelType?
    let channelName: String?
    let companyHuntingNumberID: Int?
    let companyHuntingNumberName: String?
//    let mergedContacts: JSONNull?
    let totalUnread: Int?
    let pairedAt: String?
    let lastRoomStatus: String?
    let lastFreeformStatus: Bool?
    let lastMessage: HandledContactLastMessageResponse?
    let whatsapp: HandledContactWhatsappResponse?
    let instagram: HandledContactInstagramResponse?
    
    struct HandledContactLastMessageResponse: Codable {
        let messageLogID: Int?
        let messageMetaID: String?
        let timestamp: String?
        let content: String?
        let status: String?
        let type: String?
    }
    
    struct HandledContactWhatsappResponse: Codable {
        let companyHuntingNumber: String?
        let companyHuntingPhoneID: String?
        let companyHuntingWabaID: String?
        let contactNumber: String?
    }
    
    struct HandledContactInstagramResponse: Codable {
        let companyHuntingInstagramSenderID: String?
        let companyHuntingInstagramID: String?
        let companyHuntingUsername: String?
        let contactInstagramID: String?
        let contactUsername: String?
    }
    
}
