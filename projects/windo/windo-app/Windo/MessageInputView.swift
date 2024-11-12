//
//  MessageInputView.swift
//  Windo
//
//  Created by Joey on 6/7/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class MessageInputView: UIToolbar {
    
    //MARK: Properties
    let messageTextField = UITextField()
    let sendButton = UIButton()
    
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
        messageTextField.backgroundColor = UIColor.whiteColor()
        
        sendButton.backgroundColor = backgroundColor
        sendButton.setTitle("SEND", forState: .Normal)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendButton.setTitleColor(UIColor.darkPurple(), forState: .Highlighted)
        sendButton.titleLabel?.font = UIFont.graphikMedium(13)
        
        addSubviews(messageTextField, sendButton)
    }
    
    func applyConstraints(){
        messageTextField.addConstraints(
            Constraint.ll.of(self, offset: 5),
            Constraint.ttbb.of(self, offset: 5),
            Constraint.rr.of(self, offset: -60)
        )
        
        sendButton.addConstraints(
            Constraint.ttbb.of(self),
            Constraint.lr.of(messageTextField, offset: 5),
            Constraint.rr.of(self, offset: -5)
        )
    }
}