//
//  WindoAlertView.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum WindoButtonType {
    /// The button text will appear red! Be careful!
    case destructive
    case simple
    /// The button text will appear lighter
    case secondary
}

class WindoAlertView: UIView {
    
    //MARK: Properties
    var messageContainer = UIView()
    var messageLabel = UILabel()
    var actionStackView = UIStackView()
    
    var message = ""
    var alertColor = UIColor.whiteColor()
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(color: UIColor, message: String) {
        self.init()
        alertColor = color
        self.message = message
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = UIColor.clearColor()
        
        messageContainer.backgroundColor = UIColor.whiteColor()
        messageContainer.layer.cornerRadius = 5.0
        
        messageLabel.text = message
        messageLabel.textColor = alertColor
        messageLabel.font = UIFont.graphikRegular(16)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .Center
        
        actionStackView.alignment = .Center
        actionStackView.axis = .Vertical
        actionStackView.distribution = .EqualCentering
        actionStackView.spacing = 0
        
        addSubview(messageContainer)
        addSubview(actionStackView)
        addSubview(messageLabel)
    }
    
    func applyConstraints(){
        messageContainer.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.8),
            Constraint.h.of(screenHeight * 0.2)
        )
        
        messageLabel.addConstraints(
            Constraint.ttbb.of(messageContainer, offset: 15),
            Constraint.llrr.of(messageContainer, offset: 15)
        )
        
        actionStackView.addConstraints(
            Constraint.tb.of(messageContainer, offset: 12),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth * 0.8)
        )
    }
    
    func addAction(type: WindoButtonType, title: String, action: () -> Void) {
        let newButton = UIButton()
        
        switch type {
        case .simple:
            newButton.setTitleColor(alertColor, forState: .Normal)
        case .secondary:
            newButton.setTitleColor(alertColor, forState: .Normal)
            newButton.titleLabel!.alpha = 0.65
        case .destructive:
            newButton.setTitleColor(.redColor(), forState: .Normal)
        }
        
        newButton.setTitle(title, forState: .Normal)
        newButton.addTarget(.TouchUpInside, action: action)
        newButton.backgroundColor = UIColor.whiteColor()
        
        newButton.addConstraints(
            Constraint.w.of(screenWidth * 0.8),
            Constraint.h.of(60)
        )
        
        actionStackView.addArrangedSubview(newButton)
    }
}