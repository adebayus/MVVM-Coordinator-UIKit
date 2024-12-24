//
//  CompanyBadgeView.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 24/12/24.
//

import UIKit

class CompanyBadgeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var companyName: String = "-" {
        didSet {
            companyNameLabel.text = companyName
        }
    }
    
    private lazy var companyNameLabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = companyName
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.height, bounds.width) / 2
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(companyNameLabel)
        backgroundColor = .backgroundPrimary
//        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            companyNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            companyNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            companyNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            companyNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
        ])
        
    }
        
}
