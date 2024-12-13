//
//  UIViewController+Extension.swift
//  UIKitCoordinator
//
//  Created by mymac on 16/11/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupLoadingView() {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints =  false
        
        self.view?.addSubview(loadingView)
        loadingView.isHidden = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func showLoadingView(isShow: Bool) {
        if let loadingView = findView(in: self.view, ofType: LoadingView.self) {
            loadingView.isHidden = !isShow
        }
    }
    
    func findView<T: UIView>(in view: UIView, ofType type: T.Type) -> T? {
        for subview in view.subviews {
            if let matchingView = subview as? T {
                return matchingView
            } else if let found = findView(in: subview, ofType: type) {
                return found
            }
        }
        return nil
    }
    
    @discardableResult
    func showToast(message: String, style: ToastStyle = .error ) -> ToastView {
        let toast = ToastView(
            message: message,
            style: style
        )
        toast.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toast)
        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toast.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            toast.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
        
        return toast
    }
    
    func setupCustomNavigationBar(type: TypeSetupCustomAppBar) {
        switch type {
        case .back:
            let btnItem = UIBarButtonItem(customView: CustomBackButton())
            self.navigationItem.leftBarButtonItem = btnItem
            break
        }
    }
}

enum TypeSetupCustomAppBar {
    case back
}

class CustomBackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let imageBack = UIImage(named: "chevron.left")!
        setTitle("Back", for: .normal)
        setImage(imageBack, for: .normal)
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
    }
}
