//
//  DetailUserResponseModel.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 16/12/24.
//

import Foundation

struct DetailUserResponseModel: Codable {
    let applicationUserID: String?
    let employeeID: Int?
    let companyID: Int?
    let companyName: String?
    let username: String?
    let name: String?
    let email: String?
    let dob: String?
    let gender: String?
    let address: String?
    let phoneNumber: String?
    let nationality: String?
    let photoURL: String?
    let isOnline: Bool?
    let lastOnline: String?
    let avgResponseTime: Int?
    let weeklyScore: Double?
    let device: DeviceModelResponse?
    let sundayStart: String?
    let sundayEnd: String?
    let mondayStart: String?
    let mondayEnd: String?
    let tuesdayStart: String?
    let tuesdayEnd: String?
    let wednesdayStart: String?
    let wednesdayEnd: String?
    let thursdayStart: String?
    let thursdayEnd: String?
    let fridayStart: String?
    let fridayEnd: String?
    let saturdayStart: String?
    let saturdayEnd: String?
    let permissionWorkingHour: Bool?
    let permissionIdleChat: [PermissionIdleChat]?
    
    struct DeviceModelResponse: Codable {
        let deviceID: Int?
        let platform: String?
        let version: String?
        let manufacturer: String?
        let model: String?
        let serial: String?
        let fcmToken: String?
        let createdAt: String?
        let updatedAt: String?
        let createdBy: String?
        let updatedBy: String?
    }
    
    struct PermissionIdleChat: Codable {
        let companyID: Int?
        let companyName: String?
    }
}
