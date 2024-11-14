//
//  LoginViewModel.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import RxSwift

class LoginViewModel {
    
    var coordinator: AuthCoordinator!
    
    var emailText = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
    func getEmailText() -> String { return try! emailText.value()}
}
