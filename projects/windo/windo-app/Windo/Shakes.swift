//
//  Shakes.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

protocol Shakes {
    func shake()
}

extension Shakes where Self:UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 4, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 4, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
}