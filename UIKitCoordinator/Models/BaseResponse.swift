//
//  BaseResponse.swift
//  UIKitCoordinator
//
//  Created by mymac on 15/11/24.
//

import Foundation


struct BaseResponse<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var data: T?
    var errors: [BaseErrorResponse]?
}

struct LoginResponse: Codable {
    var token: String?
}

struct BaseErrorResponse: Codable {
    var path: String?
    var message: String?
}
