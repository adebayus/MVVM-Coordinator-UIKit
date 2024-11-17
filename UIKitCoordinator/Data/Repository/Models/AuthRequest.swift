//
//  AuthRequest.swift
//  UIKitCoordinator
//
//  Created by mymac on 15/11/24.
//

import Foundation

struct AuthRequest: Codable {
    let email: String
    let password: String
    let metadata: [String: String]
}
