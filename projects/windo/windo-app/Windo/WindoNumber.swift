//
//  WindoNumber.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoNumber: UIButton {
    
    //MARK: Properties
    let highlightedBorderColor = UIColor.whiteColor().CGColor
    let fadedBorderColor = UIColor.fromHex(0xFFFFF, alpha: 0.75).CGColor
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
        configureSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.clearColor()
        layer.borderColor = fadedBorderColor
        layer.borderWidth = 1.0
        
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleLabel!.font = UIFont.graphikRegular(25)
    }
    
    internal var minimumScale: CGFloat = 1.1
    internal var pressSpringDamping: CGFloat = 0.55
    internal var releaseSpringDamping: CGFloat = 0.65
    internal var pressSpringDuration = 0.35
    internal var releaseSpringDuration = 0.45
    
    override internal func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        UIView.animateWithDuration(self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(self.minimumScale, self.minimumScale)
            self.layer.borderColor = self.highlightedBorderColor
            }, completion: nil)
    }
    
    override internal func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            self.layer.borderColor = self.fadedBorderColor
            }, completion: nil)
    }
    
    override internal func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(self)
        if !CGRectContainsPoint(self.bounds, location) {
            UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
                self.transform = CGAffineTransformIdentity
                self.layer.borderColor = self.fadedBorderColor
                }, completion: nil)
        }
    }
    
    override internal func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        UIView.animateWithDuration(self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            self.layer.borderColor = self.fadedBorderColor
            }, completion: nil)
    }
}

