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
        
        if let _ = KeychainManager.shared.getToken() {
            goToTabBar()
        } else {
            goToLogin()
        }
       
    }
    
    func goToLogin() {
        
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginViewModel.authRepository = AuthRepository()
        vc.viewModel = loginViewModel
        
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func gotoRegister() {
//        navigationController.pushViewController(RegisterViewController(), animated: true)
    }
    
    func goToTabBar() {
        let vc = UITabBarViewController(nibName: "UITabBarViewController", bundle: nil)
        let viewModel = UITabBarViewModel()
        viewModel.coordinator = self
        
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func gotoTesting() {
        let vc = TestingRXViewController(nibName: "TestingRXViewController", bundle: nil)
        let vm = TodosViewModel()
//        vm.coordinator = self
        
        vc.viewModel = vm
        self.navigationController.pushViewController(vc, animated: true)
    }
}
