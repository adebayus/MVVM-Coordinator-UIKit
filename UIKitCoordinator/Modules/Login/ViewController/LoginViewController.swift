//
//  LoginViewController.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 12/11/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var contentSVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentSV: UIStackView!
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "PrimaryRed")
        view.addSubview(statusBarView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
       
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func testing(_ sender: Any) {
        viewModel.coordinator.gotoRegister()
    }
    
}
