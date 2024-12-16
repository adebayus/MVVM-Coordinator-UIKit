//
//  ListChatTabViewModel.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/12/24.
//

import Foundation
import RxSwift
import RxRelay

class ListChatTabViewModel {
    
    let bag = DisposeBag()
    let datasFilter = BehaviorRelay<[FilterChatStatusCellModel]>(value: [
        .init(type: .all, name: "Semua"),
        .init(type: .inProgress, name: "Berlangsung"),
        .init(type: .finished, name: "Selesai"),
        .init(type: .unfinished, name: "Belum Selesai")
    ])
    
    var coordinator: ChatListCoordinator!
    var contactRepository: ContactRepository!
    var authRepository: AuthRepository!
    
    var detailUser = PublishSubject<DetailUserResponseModel?>()
    var selectedAccount = BehaviorRelay<PermissionNumberResponse?>(value: nil)
    
    var selectedFilter = BehaviorRelay<FilterChatStatusCellModel>(value: .init(type: .all, name: "Semua"))
    var userDetail = KeychainManager.shared.getUserDetail()
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    init(
        coordinator: ChatListCoordinator,
        contactRepository: ContactRepository,
        authRepository: AuthRepository
    ) {
        self.coordinator = coordinator
        self.contactRepository = contactRepository
        self.authRepository = authRepository
    }
    
    internal func goToTesting() {
        
    }
    
    func fetchDataFirst() {
        if let userDetail = KeychainManager.shared.getUserDetail() {
            detailUser.onNext(userDetail)
            fetchByHuntingNumber()
        }
        
    }
    
    func fetchByHuntingNumber() {
        
        isLoading.onNext(true)
        contactRepository.getPermissionNumbers()
            .flatMap { permissionNumber -> RxSwift.Observable<[HandledContactResponse]?> in
                
                let selectedAccountId = self.selectedAccount.value?.companyHuntingNumberID
                let param = HandledContactRequest(companyHuntingNumberId: selectedAccountId)
                
                return self.contactRepository.getHandledContacts(param: param)
            }
            .subscribe(
                onNext: { result in
                    
                },
                onError: { error in
                }
            )
            .disposed(by: bag)
    }
}

enum FilterChatStatusType {
    
    case all
    case inProgress
    case finished
    case unfinished
}

class ChatListCoordinator: Coordinator {
    
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    
}
