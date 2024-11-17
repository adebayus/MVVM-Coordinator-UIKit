//
//  LoadingView.swift
//  UIKitCoordinator
//
//  Created by mymac on 16/11/24.
//

import UIKit

class LoadingView: UIView {
    
    private lazy var overlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.isOpaque = false
        
        
        return view
    }()
    
    private lazy var activiyIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            indicator.style = .large
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        self.isUserInteractionEnabled = false
        
        self.addSubview(overlay)
        containerView.addSubview(activiyIndicator)
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            
            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            activiyIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activiyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activiyIndicator.widthAnchor.constraint(equalToConstant: 250),
            activiyIndicator.heightAnchor.constraint(equalToConstant: 125),
          
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
        
    }
    
}
