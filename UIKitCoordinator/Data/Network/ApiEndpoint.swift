//
//  ApiEndpoint.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 15/11/24.
//


enum ApiEndpoint {
    
    static let baseURL = "https://cels.mediainovasi.id"
    
    case postAuth
    case getAuth(id: Int)
    
    var path: String {
        switch self {
        case .postAuth: "/auth"
        case .getAuth(id: let id): "/auth/\(id)"
        }
    }
    
    var url: String {
        return ApiEndpoint.baseURL + path
    }
}
