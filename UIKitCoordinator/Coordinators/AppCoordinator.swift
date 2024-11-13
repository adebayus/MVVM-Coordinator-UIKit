//
//  AppCoordinator.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import UIKit


class AppCoordinator: Coordinator {
    
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    
    
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let isAuthenticated = false
        goToLogin()
    }
    
    func goToLogin() {
//        let navController = UINavigationController()
        let authCoor = AuthCoordinator(navigationController: navigationController)
        authCoor.start()
    }
    
}
