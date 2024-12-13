//
//  PrimaryBackgroundVIew.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/12/24.
//

import UIKit

class RoundedTopView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        layer.cornerRadius = 36
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
