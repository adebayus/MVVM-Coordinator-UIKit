//
//  PermissionNumberResponse.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 16/12/24.
//

import Foundation

struct PermissionNumberResponse: Codable {
    let companyHuntingNumberID: Int?
    let companyID: Int?
    let companyName: String?
    let companyHuntingName: String?
    let channelID: Int?
    let channelName: String?
    let whatsapp: PermissionNumberWhatsappResponse?
    let instagram: PermissionNumberInstagramResponse?
    
    struct PermissionNumberWhatsappResponse: Codable {
        let companyHuntingNumber: String?
        let companyHuntingPhoneID: String?
        let companyHuntingWabaID: String?
    }
    
    struct PermissionNumberInstagramResponse: Codable {
        let companyHuntingInstagramID: String?
        let companyHuntingInstagramSenderID: String?
        let companyHuntingUsername: String?
    }
}
