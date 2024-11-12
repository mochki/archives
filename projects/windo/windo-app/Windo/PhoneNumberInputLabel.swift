//
//  PhoneNumberInputLabel.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class PhoneNumberInputLabel: UIView, Shakes {
    
    // MARK: Properties
    var lastInputIndex = 0
    
    var characterFont = UIFont.graphikRegular(phoneInputCharacterSize)
    var characterSize: CGFloat = phoneInputCharacterSize
    var separatorFadeAlpha:CGFloat = 0.25
    
    let leftParentheses = UILabel()
    let first = InputCharacter()
    let second = InputCharacter()
    let third = InputCharacter()
    let rightParentheses = UILabel()
    let fourth = InputCharacter()
    let fifth = InputCharacter()
    let sixth = InputCharacter()
    let hyphen = UILabel()
    let seventh = InputCharacter()
    let eighth = InputCharacter()
    let ninth = InputCharacter()
    let tenth = InputCharacter()
    
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
        seventh.character = ""
        eighth.character = ""
        ninth.character = ""
        tenth.character = ""
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
        case 7:
            return seventh
        case 8:
            return eighth
        case 9:
            return ninth
        case 10:
            return tenth
        default:
            return nil
        }
    }
    
    func toggleSeparatorFadeIfNeeded(indexEdited: Int) {
        var label = UILabel()
        switch indexEdited {
        case 1:
            label = leftParentheses
        case 3:
            label = rightParentheses
        case 6:
            label = hyphen
        default:
            return
        }
        
        var targetAlpha:CGFloat = 1.0
        
        // if backspace, fade the separator
        if getInputByIndex(indexEdited)?.character == "" {
            targetAlpha = separatorFadeAlpha
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
            self.layoutIfNeeded()
            label.alpha = targetAlpha
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
        
        leftParentheses.text = "("
        leftParentheses.textColor = separatorColor
        leftParentheses.textAlignment = .Right
        leftParentheses.font = characterFont
        leftParentheses.alpha = separatorFadeAlpha
        
        rightParentheses.text = ")"
        rightParentheses.textColor = separatorColor
        rightParentheses.font = characterFont
        rightParentheses.alpha = separatorFadeAlpha
        
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
        seventh.characterLabel.font = characterFont
        eighth.characterLabel.font = characterFont
        ninth.characterLabel.font = characterFont
        tenth.characterLabel.font = characterFont
        
        addSubviews(leftParentheses, first, second, third, rightParentheses, fourth, fifth, sixth, hyphen, seventh, eighth, ninth, tenth)
    }
    
    func applyConstraints(){
        leftParentheses.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.h.of(characterSize),
            Constraint.w.of(characterSize/2)
        )
        
        first.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(leftParentheses),
            Constraint.wh.of(characterSize)
        )
        
        second.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(first),
            Constraint.wh.of(characterSize)
        )
        
        third.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(second),
            Constraint.wh.of(characterSize)
        )
        
        rightParentheses.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(third),
            Constraint.h.of(characterSize),
            Constraint.w.of(characterSize/2)
        )
        
        fourth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(rightParentheses),
            Constraint.wh.of(characterSize)
        )
        
        fifth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(fourth),
            Constraint.wh.of(characterSize)
        )
        
        sixth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(fifth),
            Constraint.wh.of(characterSize)
        )
        
        hyphen.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(sixth),
            Constraint.wh.of(characterSize/2)
        )
        
        seventh.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(hyphen),
            Constraint.wh.of(characterSize)
        )
        
        eighth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(seventh),
            Constraint.wh.of(characterSize)
        )
        
        ninth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(eighth),
            Constraint.wh.of(characterSize)
        )
        
        tenth.addConstraints(
            Constraint.cycy.of(self),
            Constraint.lr.of(ninth),
            Constraint.wh.of(characterSize)
        )
    }
}
