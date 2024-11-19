//
//  AuthRepository.swift
//  UIKitCoordinator
//
//  Created by mymac on 15/11/24.
//

import Foundation
import RxSwift
import Alamofire

protocol AuthRepositoryProtocol {
    func auth(request: AuthRequest) -> Observable<LoginResponse?>
}

class AuthRepository: AuthRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func auth(
        request: AuthRequest
    ) -> RxSwift.Observable<LoginResponse?> {
        print("[request]", request)
        let paramaters: Parameters = [
            "email": request.email,
            "password": request.password,
            "metadata": request.metadata
        ]
        return networkService.request(
            .postAuth,
            method: .post,
            paramaters: paramaters,
            encoding: JSONEncoding.prettyPrinted
        )
    }
    
}

