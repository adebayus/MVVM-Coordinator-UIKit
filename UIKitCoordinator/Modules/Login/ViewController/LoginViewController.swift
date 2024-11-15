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
    
    @IBOutlet weak var containerEmailView: UIView!
    @IBOutlet weak var emailBorderBottomView: UIView!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var submitButton: UICapsuleButton!
    
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
        
        setupTapGesture()
        setupBind()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToForgetPassword))
        forgetPasswordLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupBind() {
        
        emailTextfield.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe { [self] (value) in
                switch value  {
                case .invalidFormat:
                    updateErrorTF(tf: emailTextfield, isError: true, errMsg: "Email invalid")
                    break
                case .emptyText:
                    updateErrorTF(tf: emailTextfield, isError: true, errMsg: "Empty form")
                    break
                case nil:
                    updateErrorTF(tf: emailTextfield, isError: false, errMsg: nil)
                    break
                }
            }.disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
        
        
        Observable.combineLatest(viewModel.isValidEmail, viewModel.isValidPassword) { validEmail, validPass in
            return validEmail == nil && validPass == nil
        }
        .bind(to: submitButton.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    
    func updateErrorTF(
        tf: UITextField,
        isError: Bool = true,
        errMsg: String?
    ) {
        
        tf.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.gray.cgColor
        emailBorderBottomView.backgroundColor = isError ? .red : .gray
        errorEmailLabel.text = errMsg
        
        errorEmailLabel.isHidden = !isError
        
    }
    
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
//        print(viewModel.getEmailText())
    }
    
    
    @IBAction func testing(_ sender: Any) {
        viewModel.coordinator.gotoRegister()
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.contentSVBottomConstraint.constant = 100
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.contentSVBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func moveToForgetPassword() {
        viewModel.openForgetPassword()
    }
    
    
}
