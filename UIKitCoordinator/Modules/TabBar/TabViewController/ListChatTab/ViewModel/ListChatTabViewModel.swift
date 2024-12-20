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
        .init(type: .new, name: "New"),
        .init(type: .inProgress, name: "Berlangsung"),
        .init(type: .finished, name: "Selesai"),
        .init(type: .unfinished, name: "Belum Selesai")
    ])
    
    var coordinator: ChatListCoordinator!
    var contactRepository: ContactRepository!
    var authRepository: AuthRepository!
    
    var detailUser = PublishSubject<DetailUserResponseModel?>()
    var lisAccount = BehaviorRelay<[PermissionNumberResponse]>(value: [])
    var selectedAccount = BehaviorRelay<PermissionNumberResponse?>(value: nil)
    
    var rawListChat = BehaviorRelay<[HandledContactResponse]>(value: [])
    var listChat = BehaviorRelay<[HandledContactResponse]>(value: [])
    
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
                
                self.lisAccount.accept(permissionNumber ?? [])
                
                return self.contactRepository.getHandledContacts(param: param)
            }
            .subscribe(
                onNext: { result in
                    self.rawListChat.accept(result ?? [])
                    self.isLoading.onNext(false)
                },
                onError: { error in
                    self.isLoading.onNext(false)
                }
            )
            .disposed(by: bag)
    }
    
    func mappingFilterChat(selectedFilter: FilterChatStatusCellModel) {
        
        let rawListChat = rawListChat.value
        
        var resultChatList: [HandledContactResponse] = []
        
        switch selectedFilter.type {
        case .all:
            resultChatList = rawListChat
            break
        case .new:
            resultChatList = rawListChat.filter { !($0.lastFreeformStatus ?? false) }
            break
        case .inProgress:
            resultChatList = rawListChat.filter { $0.lastRoomStatus == .ongoing }
            break
        case .finished:
            resultChatList = rawListChat.filter { $0.lastRoomStatus == .resolved }
            break
        case .unfinished:
            resultChatList = rawListChat.filter { $0.lastRoomStatus == .unresolved }
            break
        }
        
        self.listChat.accept(resultChatList)
    }
    
    func mapperChatTableViewCell(data: HandledContactResponse) -> ChatTableViewCellModel {
        
        let mapping: ChatTableViewCellModel = .init(
            type: .previewChat,
            username: data.contactName ?? "",
            isBlocked: data.isBlocked ?? false,
            statusChat: data.lastRoomStatus ?? .unresolved,
            lateMessageDate: data.lastMessage?.timestamp ?? "-",
            lastMessage: data.lastMessage?.content ?? "-",
            companyName: data.companyName ?? "-",
            unreadChat: data.totalUnread ?? 0
        )
        
        return mapping
    }
    
    
}

enum FilterChatStatusType {
    
    case all
    case new
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
