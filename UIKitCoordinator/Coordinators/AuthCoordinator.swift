//
//  AuthCoordinator.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func start() {
        let isAuthenticated = false
        
        if (isAuthenticated) {
            
        } else {
            goToLogin()
        }
        
    }
    
    func goToLogin() {
        
        let vc = ViewController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        vc.viewModel = loginViewModel
        
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
}
