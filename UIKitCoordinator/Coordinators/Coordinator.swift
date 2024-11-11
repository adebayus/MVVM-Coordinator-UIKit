//
//  Coordinator.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
