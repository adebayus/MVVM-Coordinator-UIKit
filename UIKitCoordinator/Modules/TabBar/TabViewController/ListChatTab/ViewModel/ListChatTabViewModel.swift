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
    var coordinator: ChatListCoordinator!
    
    let datasFilter = BehaviorRelay<[FilterChatStatusCellModel]>(value: [
        .init(type: .all, name: "Semua"),
        .init(type: .inProgress, name: "Berlangsung"),
        .init(type: .finished, name: "Selesai"),
        .init(type: .unfinished, name: "Belum Selesai")
    ])
    var selectedFilter = BehaviorRelay<FilterChatStatusCellModel>(value: .init(type: .all, name: "Semua"))
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
