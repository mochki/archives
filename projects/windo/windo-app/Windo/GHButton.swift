//
//  UIButton+GuildHall.swift
//  GuildHall
//
//  Created by Nelson, J. Edmond on 12/14/15.
//  Copyright © 2015 Joey Nelson. All rights reserved.
//

import UIKit

class GHButton: UIButton {
    
    // A new highlightedBackgroundColor, which shows on tap
    var highlightedBackgroundColor: UIColor?
    // A temporary background color property, which stores the original color while the button is highlighted
    var temporaryBackgroundColor: UIColor?
    
    // Set up a property observer for the highlighted property, so the color can be changed
    @objc override var highlighted: Bool {
        didSet {
            if highlighted {
                if temporaryBackgroundColor == nil {
                    if backgroundColor != nil {
                        if let highlightedColor = highlightedBackgroundColor {
                            temporaryBackgroundColor = backgroundColor
                            backgroundColor = highlightedColor
                        } else {
                            temporaryBackgroundColor = backgroundColor
                            backgroundColor = darkenColor(temporaryBackgroundColor!)
                        }
                    }
                }
            } else {
                if let temporaryColor = temporaryBackgroundColor {
                    backgroundColor = temporaryColor
                    temporaryBackgroundColor = nil
                }
            }
        }
    }
    
    func darkenColor(color: UIColor) -> UIColor {
        
        var red = CGFloat(), green = CGFloat(), blue = CGFloat(), alpha = CGFloat()
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        red = max(red - 0.15, 0.0)
        green = max(green - 0.15, 0.0)
        blue = max(blue - 0.15, 0.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    // The following code is taken from APSpringButton
    //
    //  APSpringButton.swift
    //  Copyright © 2015 Appsidian. All rights reserved.
    //
    
    internal var minimumScale: CGFloat = 0.95
    internal var pressSpringDamping: CGFloat = 0.4
    internal var releaseSpringDamping: CGFloat = 0.35
    internal var pressSpringDuration = 0.4
    internal var releaseSpringDuration = 0.5
    
    override internal func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        UIView.animateWithDuration(self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(self.minimumScale, self.minimumScale)
            }, completion: nil)
    }
    
    override internal func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    override internal func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(self)
        if !CGRectContainsPoint(self.bounds, location) {
            UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
                self.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
    }
    
    override internal func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    
}