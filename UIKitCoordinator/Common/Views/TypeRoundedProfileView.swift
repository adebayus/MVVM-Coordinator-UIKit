//
//  TypeRoundedProfileView.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 20/12/24.
//


import UIKit

enum TypeRoundedProfileView {
    case previewChat
    case general
    case selected
}

class RoundedProfileView: UIView {
    
    private lazy var bgColor = UIColor.randomPastelColor()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = bgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.font = UIFont.setFont(font: .OpensansBold, size: 16)
//        lbl.textColor = .textColorPrimary
        lbl.text = fullname
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var blockedImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ImageBlockContact")
        return iv
    }()
    
    private lazy var statusImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = statusImage()
        return iv
    }()
    
    private lazy var selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "StatusResolved")
        return iv
    }()
    
    var fullname: String = "AB" {
        didSet {
            updateFullname()
        }
    }
    
    var status: RoomStatusType = .ongoing {
        didSet {
            updateStatusView()
        }
    }
    
    var isBlocked: Bool = false {
        didSet {
            updateBlockedImage()
        }
    }
    
    var type: TypeRoundedProfileView = .general {
        didSet {
            setupStyle()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            updateSelectedView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupView()
        setupStyle()
    }
    
    private func setupView() {
        contentView.addSubview(fullnameLabel)
        setupStyle()
        addSubview(contentView)
        addSubview(blockedImageView)
        addSubview(statusImageView)
        addSubview(selectedImageView)
        setupConstraint()
    }
    
    private func setupStyle() {
        switch type {
        case .previewChat:
            blockedImageView.isHidden = false
            statusImageView.isHidden = false
            selectedImageView.isHidden = true
            break
        case .general:
            statusImageView.isHidden = true
            blockedImageView.isHidden = true
            selectedImageView.isHidden = true
            break
        case .selected:
            statusImageView.isHidden = true
            blockedImageView.isHidden = true
            selectedImageView.isHidden = false
        }
    }
    
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            fullnameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            fullnameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fullnameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            fullnameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            blockedImageView.topAnchor.constraint(equalTo: topAnchor),
            blockedImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blockedImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.41),
            blockedImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.41),
            
            statusImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.41),
            statusImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.41),
            
            selectedImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.41),
            selectedImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.41),
            
        ])
    }
    
    private func updateFullname() {
        let components = fullname.uppercased().split(separator: " ") // Split the name into parts
        var initials = components.compactMap { $0.first }
        if components.count == 1 {
            // If only one component, take the first letter of the single word
            initials = [components[0].first].compactMap { $0 }
        } else {
            // If there are multiple components, take the first letter from each part
            initials = components.prefix(2).compactMap { $0.first }
        }
        fullnameLabel.text = initials.map{String($0)}.joined()
    }
    
    private func updateStatusView() {
        statusImageView.image = statusImage()
    }
    
    private func updateBlockedImage() {
        blockedImageView.isHidden = !isBlocked
    }
    
    private func updateSelectedView() {
        selectedImageView.isHidden = !isSelected
    }
    
    private func statusImage() -> UIImage? {
        switch status {
        case .ongoing:
            return UIImage(named: "StatusOngoing")
        case .resolved:
            return UIImage(named: "StatusResolved")
        case .unresolved:
            return UIImage(named: "StatusUnresolved")
        case .newexpired:
            return nil
        }
    }
    
}


extension UIColor {
    static func randomPastelColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0.7...1.0) // Higher values for light pastel effect
        let randomGreen = CGFloat.random(in: 0.7...1.0)
        let randomBlue = CGFloat.random(in: 0.7...1.0)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
