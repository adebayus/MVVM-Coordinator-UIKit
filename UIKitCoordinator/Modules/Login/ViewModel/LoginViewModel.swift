//
//  LoginViewModel.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import RxSwift

enum ErrorForm {
    case emptyText
    case invalidFormat
}

class LoginViewModel {
    
    var coordinator: AuthCoordinator!
    
    var emailText = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    
    var isValidEmail: Observable<ErrorForm?> {
        return emailText
            .map { value in
                print(value, self.isValidEmailFormat(value), "testing")
                if value.isEmpty { return .emptyText}
                else if !self.isValidEmailFormat(value) { return .invalidFormat}
                return nil
            }
            .distinctUntilChanged()
    }
    
    var isValidPassword: Observable<ErrorForm?> {
        return passwordText
            .map { value in
                return value.isEmpty ? .emptyText : nil
            }.distinctUntilChanged()
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func openForgetPassword() {
        if let url = URL(string: "https://cels.mediainovasi.id/Account/ForgotPassword") {
            UIApplication.shared.open(url)
        }
    }
    
}
