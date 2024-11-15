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
            let vc = TestingRXViewController(nibName: "TestingRXViewController", bundle: nil)
            let todoViewModel = TodosViewModel(repository: TodoRepository())
            vc.viewModel = todoViewModel
            
            navigationController.pushViewController(vc, animated: true)
        } else {
            goToLogin()
        }
        
       
    }
    
    func goToLogin() {
        
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        vc.viewModel = loginViewModel
        
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func gotoRegister() {
//        navigationController.pushViewController(RegisterViewController(), animated: true)
    }
    
    
}
