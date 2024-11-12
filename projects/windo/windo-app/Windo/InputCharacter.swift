//
//  InputCharacter.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InputCharacter : UIView {
    
    // MARK: Properties
    var character = "" {
        didSet {
            if character == "" {
                animateCharacterRemove()
            } else {
                characterLabel.text = character
                animateCharacterSet()
            }
        }
    }
    
    let characterLabel = UILabel()
    let fadedUnderline = UIView()
    let loadedUnderline = UIView()
    
    internal var characterSize: CGFloat = phoneInputCharacterSize
    internal var font = UIFont.graphikRegular(phoneInputCharacterSize)
    
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(size: CGFloat, font: UIFont) {
        self.init()
        self.characterSize = size
        self.font = font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        characterLabel.textAlignment = .Center
        characterLabel.font = self.font
        characterLabel.textColor = UIColor.whiteColor()
        characterLabel.alpha = 0.0
        
        fadedUnderline.backgroundColor = UIColor.whiteColor()
        fadedUnderline.alpha = 0.25
        
        addSubview(characterLabel)
        addSubview(fadedUnderline)
    }
    
    func applyConstraints() {
        characterLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self, offset: -15),
            Constraint.w.of(characterSize),
            Constraint.h.of(characterSize)
        )
        
        fadedUnderline.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.bb.of(self),
            Constraint.w.of(characterSize * 0.75),
            Constraint.h.of(2)
        )
    }
    
    func animateCharacterSet() {
        characterLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(characterSize),
            Constraint.h.of(characterSize)
        )
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
                self.layoutIfNeeded()
                self.characterLabel.alpha = 1.0
                self.fadedUnderline.alpha = 1.0
            }, completion: nil)
    }
    
    func animateCharacterRemove() {
        characterLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self, offset: -15),
            Constraint.w.of(characterSize),
            Constraint.h.of(characterSize)
        )
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.layoutIfNeeded()
            self.characterLabel.alpha = 0.0
            self.fadedUnderline.alpha = 0.25
            }, completion: { finished in
                self.characterLabel.text = self.character
        })
    }
}


