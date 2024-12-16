//
//  ApiEndpoint.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 15/11/24.
//


enum ApiEndpoint {
    
    static let baseURL = "https://cure-api.mediainovasi.id"
    
    case getAuth(id: Int)
    case postAuth
    case getDetailUser
    
    case getPermisionNumber
    case getHandledNumber
    
    var path: String {
        switch self {
        case .postAuth: "/auth/login"
        case .getAuth(id: let id): "/auth/\(id)"
        case .getDetailUser: "/auth"
        case .getPermisionNumber: "/contact/permission"
        case .getHandledNumber: "/contact"
        }
    }
    
    var url: String {
        return ApiEndpoint.baseURL + "/api" + path
    }
}
