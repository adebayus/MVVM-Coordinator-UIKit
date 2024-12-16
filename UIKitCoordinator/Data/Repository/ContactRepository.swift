//
//  ContactRepository.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 16/12/24.
//

import Foundation
import RxSwift
import Alamofire

class ContactRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func getPermissionNumbers() -> RxSwift.Observable<[PermissionNumberResponse]?>   {
        return networkService.request(.getPermisionNumber)
    }
    
    func getHandledContacts(param: HandledContactRequest) -> RxSwift.Observable<[HandledContactResponse]?> {
        
        var params: Parameters = [:]
        
        if let requirePaging = param.requirePaging {
            params["requirePaging"] = requirePaging
        }
        
        if let orderBy = param.orderBy {
            params["orderBy"] = orderBy
        }
        
        if let page = param.page {
            params["page"] = page
        }
        
        if let size = param.size {
            params["size"] = size
        }
        
        if let companyHuntingNumberId = param.companyHuntingNumberId {
            params["companyHuntingNumberId"] = companyHuntingNumberId
        }
        
        print(params, "[params]")
        
        return networkService.request(
            .getHandledNumber,
            paramaters: params,
            encoding: URLEncoding.default
        )
    }
}
