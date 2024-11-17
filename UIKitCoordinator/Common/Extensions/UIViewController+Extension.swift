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
        
//        let view = self.view
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
}

