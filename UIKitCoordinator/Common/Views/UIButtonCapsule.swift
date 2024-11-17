//
//  UICapsuleButton.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 15/11/24.
//

import UIKit

class UIButtonCapsule: UIButton {
    
    var bg: UIColor = .backgroundPrimary
    
    var titleColor: UIColor = .white
    var disabledTitleColor: UIColor = .lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        updateAppearance()
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        if !isEnabled {
            setTitleColor(disabledTitleColor, for: .disabled)
        } else {
            tintColor = bg
            setTitleColor(titleColor, for: .normal)
        }
    }
}
