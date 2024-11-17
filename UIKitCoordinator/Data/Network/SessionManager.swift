//
//  SessionManager.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 15/11/24.
//

import Foundation
import Alamofire


class SessionManager {
    
    static let shared: Session = {
        let interceptor = SessionInterceptor()
        return Session(interceptor: interceptor)
    }()
    
}


final class SessionInterceptor: RequestInterceptor {
    private let maxRetry: Int =  3
    private var retryCount: Int = 1
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            if retryCount > maxRetry {
//                retryCount += 1
//                completion(.retryWithDelay(1))
//            } else {
////                 handleLogout()
//                completion(.doNotRetry)
//            }
//        } else {
//            retryCount = 1
//            completion(.doNotRetry)
//        }
        
        completion(.doNotRetry)
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
        var headerRequest = urlRequest
        headerRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        headerRequest.setValue("\(Constants.API_KEY)", forHTTPHeaderField: "x-api-key")
        
        if let token = KeychainManager.shared.getToken() {
            headerRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        completion(.success(headerRequest))
        
    }
    
    func handleLogout() {
        
    }
}
