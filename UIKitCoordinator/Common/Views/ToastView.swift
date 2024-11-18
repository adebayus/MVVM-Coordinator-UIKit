//
//  ToastView.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 18/11/24.
//

import UIKit

enum ToastStyle {
    case success
    case warning
    case error
}

class ToastView: UIView {

    private var hideTimer: Timer?
    
    var styleToast: ToastStyle
    var message: String = ""
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(
        message: String,
        style: ToastStyle = .error,
        autoHideDuration: TimeInterval = 10.0
    ) {
        
        self.message = message
        self.styleToast = style
        
        super.init(frame: .zero)
        
        self.setupView()
        self.hideTimer = Timer.scheduledTimer(withTimeInterval: autoHideDuration, repeats: false, block: { [weak self] _ in
            self?.hideToast()
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        switch styleToast {
        case .success:
            backgroundColor = .green
        case .warning:
            backgroundColor = .yellow
        case .error:
            backgroundColor = .red
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .red
        
        label.text = message
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
    
    func hideToast() {
        hideTimer?.invalidate()
        hideTimer = nil
        
        UIView.animate(withDuration: 0.5, animations: {
            self.removeFromSuperview()
        })
    }

}
