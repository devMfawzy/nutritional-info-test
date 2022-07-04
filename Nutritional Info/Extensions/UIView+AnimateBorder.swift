//
//  UIView+AnimateBorder.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

extension UIView {
    func animateBorderColor(fromColor: UIColor? = nil, toColor: UIColor, duration: Double) {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = fromColor?.cgColor ?? layer.borderColor
        borderColorAnimation.toValue = toColor.cgColor
        borderColorAnimation.duration = duration
        borderColorAnimation.repeatCount = Float.infinity
        layer.add(borderColorAnimation, forKey: "borderColor")

        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = layer.borderWidth
        borderWidthAnimation.toValue = 0
        borderWidthAnimation.duration = duration
        borderWidthAnimation.repeatCount = Float.infinity
        layer.add(borderWidthAnimation, forKey: "borderWidth")
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [borderColorAnimation, borderWidthAnimation]
        layer.add(animationGroup, forKey: "borderChangeAnimationGroup")
    }
    
    func stopBorderAnimation() {
        layer.removeAllAnimations()
    }
}
