//
//  CircleView.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

class CircleView: UIView {
    private let borderWidth: CGFloat
    private let borderColor: UIColor
    private let gradientColors: [UIColor]
    
    init(borderWidth: CGFloat, borderColor: UIColor, gradientColors: [UIColor]) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.gradientColors = gradientColors
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let circleFillGradient =  createGradientLayer()
        circleFillGradient.frame = bounds
        circleFillGradient.colors = gradientColors.map { $0.cgColor }
        layer.insertSublayer(circleFillGradient, at: 0)
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = bounds.width/2
        clipsToBounds = true
    }
    
    private func createGradientLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }
}
