//
//  LoginViewModel.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import RxSwift
import SwiftKeychainWrapper

enum ErrorForm {
    case emptyText
    case invalidFormat
}

class LoginViewModel {
    
    let bag = DisposeBag()
    var coordinator: AuthCoordinator!
    var authRepository: AuthRepository!
    
    var emailText = BehaviorSubject<String>(value: "")
    var passwordText = BehaviorSubject<String>(value: "")
    var isLoading = BehaviorSubject<Bool>(value: false)
    var error = BehaviorSubject<Error?>(value: nil)
    
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
    
    private func storeToken(token: String) {
        KeychainManager.shared.setToken(value: token)
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
    
    
    func submit() {
        guard let email = try? emailText.value(), let password = try? passwordText.value() else { return }
        
        print("[submit]", email, password)
        let metadata = DeviceManager.shared.getMetadataDevice()
        
        let request = AuthRequest(
            email: email,
            password: password,
            metadata: metadata
        )
        
        isLoading.onNext(true)
        
        authRepository.auth(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { response in
                    
                    if let token = response.data?.token {
//                        self.storeToken(token: token)
                        self.coordinator.goToTabBar()
                    }
                    
                },
                onError: { error in
                    print("[auth] -", error)
                    self.isLoading.onNext(false)
                    self.error.onNext(error)
                }, onCompleted: {
                    print("[auth] -", "onCompleted")
                    self.isLoading.onNext(false)
                }
                
            )
            .disposed(by: bag)
    }
    
}
