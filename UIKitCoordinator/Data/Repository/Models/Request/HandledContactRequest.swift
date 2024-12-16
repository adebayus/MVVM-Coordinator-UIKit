//
//  HandledContactRequest.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 16/12/24.
//

import Foundation

struct HandledContactRequest: Codable {
    var page: Int? = nil
    var size: Int? = nil
    var requirePaging: Bool?
    var orderBy: String?
    var companyHuntingNumberId: Int?
}
