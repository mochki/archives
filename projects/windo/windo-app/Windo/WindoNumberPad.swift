//
//  WindoNumberPad.swift
//  Windo
//
//  Created by Joey on 7/6/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit


protocol WindoNumberPadDelegate {
    func numberTapped(number: Int)
}

class WindoNumberPad: UIView {
    
    //MARK: Properties
    var delegate: WindoNumberPadDelegate? = nil
    
    let container = UIStackView()
    let topRow = UIStackView()
    let midRow = UIStackView()
    let bottomRow = UIStackView()
    let zeroRow = UIStackView()
    
    let buttonSize:CGFloat = screenWidth * 0.1867
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        let spacing:CGFloat = screenWidth * 0.039
        
        container.alignment = .Center
        container.axis = .Vertical
        container.distribution = .EqualSpacing
        container.spacing = spacing
        
        topRow.alignment = .Center
        topRow.axis = .Horizontal
        topRow.distribution = .EqualSpacing
        topRow.spacing = spacing
        
        midRow.alignment = .Center
        midRow.axis = .Horizontal
        midRow.distribution = .EqualSpacing
        midRow.spacing = spacing
        
        bottomRow.alignment = .Center
        bottomRow.axis = .Horizontal
        bottomRow.distribution = .EqualSpacing
        bottomRow.spacing = spacing
        
        zeroRow.alignment = .Center
        zeroRow.axis = .Horizontal
        zeroRow.distribution = .EqualSpacing
        zeroRow.spacing = spacing
        
        for i in 1...3 {
            let newTop = constructButton(i)
            let newMid = constructButton(i + 3)
            let newBottom = constructButton(i + 6)
            
            topRow.addArrangedSubview(newTop)
            midRow.addArrangedSubview(newMid)
            bottomRow.addArrangedSubview(newBottom)
        }
        
        let empty = constructButton(42)
        empty.alpha = 0
        let zero = constructButton(0)
        let backspace = constructButton("<", tag: -1)
        zeroRow.addArrangedSubview(empty)
        zeroRow.addArrangedSubview(zero)
        zeroRow.addArrangedSubview(backspace)
        
        container.addArrangedSubview(topRow)
        container.addArrangedSubview(midRow)
        container.addArrangedSubview(bottomRow)
        container.addArrangedSubview(zeroRow)
        
        addSubview(container)
    }
    
    func applyConstraints(){
        container.fillSuperview()
    }
    
    func numberTapped(button: UIButton){
        guard let _ = delegate else { return }
        delegate?.numberTapped(button.tag)
    }
    
    func constructButton(number: Int) -> WindoNumber{
        let newNumber = WindoNumber()
        newNumber.setTitle(String(number), forState: .Normal)
        newNumber.tag = number
        newNumber.widthAnchor.constraintEqualToConstant(buttonSize).active = true
        newNumber.heightAnchor.constraintEqualToConstant(buttonSize).active = true
        newNumber.addTarget(self, action: #selector(WindoNumberPad.numberTapped(_:)), forControlEvents: .TouchUpInside)
        
        return newNumber
    }
    
    func constructButton(string: String, tag: Int) -> WindoNumber {
        let newNumber = WindoNumber()
        newNumber.setTitle(string, forState: .Normal)
        newNumber.tag = tag
        newNumber.widthAnchor.constraintEqualToConstant(buttonSize).active = true
        newNumber.heightAnchor.constraintEqualToConstant(buttonSize).active = true
        newNumber.addTarget(self, action: #selector(WindoNumberPad.numberTapped(_:)), forControlEvents: .TouchUpInside)
        
        return newNumber
    }
}