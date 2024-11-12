//
//  CodeInputLabel.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//


import UIKit

class CodeInputLabel: UIView, Shakes {
    
    // MARK: Properties
    var lastInputIndex = 0
    
    var characterFont = UIFont.graphikRegular(phoneInputCharacterSize)
    var characterSize: CGFloat = phoneInputCharacterSize
    var separatorFadeAlpha:CGFloat = 0.25
    
    let first = InputCharacter()
    let second = InputCharacter()
    let third = InputCharacter()
    let hyphen = UILabel()
    let fourth = InputCharacter()
    let fifth = InputCharacter()
    let sixth = InputCharacter()
    
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(size: CGFloat, font: UIFont) {
        self.init()
        self.characterSize = size
        self.characterFont = font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setNumberForIndex(number: String, index: Int) {
        guard let input = getInputByIndex(index) else { return }
        input.character = number
        lastInputIndex = index
        toggleSeparatorFadeIfNeeded(index)
    }
    
    func removeLastInput() {
        setNumberForIndex("", index: lastInputIndex)
        lastInputIndex -= 1
    }
    
    func clearAll() {
        first.character = ""
        second.character = ""
        third.character = ""
        fourth.character = ""
        fifth.character = ""
        sixth.character = ""
    }
    
    func getInputByIndex(index: Int) -> InputCharacter?{
        switch index {
        case 1:
            return first
        case 2:
            return second
        case 3:
            return third
        case 4:
            return fourth
        case 5:
            return fifth
        case 6:
            return sixth
        default:
            return nil
        }
    }
    
    func toggleSeparatorFadeIfNeeded(indexEdited: Int) {
        if indexEdited != 3 {
            return
        }
        
        var targetAlpha:CGFloat = 1.0
        // if backspace, fade the separator
        if getInputByIndex(indexEdited)?.character == "" {
            targetAlpha = separatorFadeAlpha
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
            self.layoutIfNeeded()
            self.hyphen.alpha = targetAlpha
            }, completion: nil)
    }
    
    // MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        let separatorColor = UIColor.whiteColor()
        
        hyphen.text = "-"
        hyphen.textColor = separatorColor
        hyphen.textAlignment = .Center
        hyphen.font = characterFont
        hyphen.alpha = separatorFadeAlpha
        
        first.characterLabel.font = characterFont
        second.characterLabel.font = characterFont
        third.characterLabel.font = characterFont
        fourth.characterLabel.font = characterFont
        fifth.characterLabel.font = characterFont
        sixth.characterLabel.font = characterFont
        
        addSubviews(first, second, third, hyphen,fourth, fifth, sixth)
    }
    
    func applyConstraints(){
        first.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(second, offset: -characterSize),
            Constraint.wh.of(characterSize)
        )
        
        second.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(third, offset: -characterSize),
            Constraint.wh.of(characterSize)
        )
        
        third.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(hyphen, offset: -characterSize),
            Constraint.wh.of(characterSize)
        )
        
        hyphen.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(self),
            Constraint.wh.of(characterSize/2)
        )
        
        fourth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(hyphen, offset: characterSize),
            Constraint.wh.of(characterSize)
        )
        
        fifth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(fourth, offset: characterSize),
            Constraint.wh.of(characterSize)
        )
        
        sixth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(fifth, offset: characterSize),
            Constraint.wh.of(characterSize)
        )
    }
}