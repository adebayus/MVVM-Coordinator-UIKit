//
//  LoginViewController.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 12/11/24.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var contentSVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentSV: UIStackView!
    
    var disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "background_primary")
        view.addSubview(statusBarView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupBind()
        // Do any additional setup after loading the view.
    }
    
    func setupBind() {
        emailTextfield.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        viewModel.emailText.subscribe(
            onNext: { value in
                print(value,"")
            }
        ).disposed(by: disposeBag)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        print(viewModel.getEmailText())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.contentSVBottomConstraint.constant = 100
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
//            self.contentSV.layoutIfNeeded()
        })
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.contentSVBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    @objc func dismissKeyboard() {
        // Dismiss the keyboard
        view.endEditing(true)
    }
    
    @IBAction func testing(_ sender: Any) {
        viewModel.coordinator.gotoRegister()
    }
    
}
