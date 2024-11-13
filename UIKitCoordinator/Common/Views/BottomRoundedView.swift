//
//  BottomRoundedView.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 12/11/24.
//


import UIKit

class BottomRoundedView: UIView {

    @IBInspectable var fillColor: UIColor = UIColor.white {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }
    
    private let shapeLayer = CAShapeLayer() // Store shape layer as a property
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.layer.insertSublayer(shapeLayer, at: 0) // Add shape layer once
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update path whenever layout changes
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - 20))
        path.addQuadCurve(to: CGPoint(x: 0, y: bounds.height - 20), controlPoint: CGPoint(x: bounds.width / 2, y: bounds.height + 20))
        path.close()
        
        // Animate the path change
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = shapeLayer.path
        animation.toValue = path.cgPath
        animation.duration = 0.3 // Duration of the animation
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // Apply the animation
        shapeLayer.add(animation, forKey: "pathAnimation")
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
    }
}
