//
//  IncomingChatCell.swift
//  Windo
//
//  Created by Joey on 6/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class IncomingChatCell: UITableViewCell {
    
    //MARK: Properties
    let container = UIView()
    let message = UILabel()
    let senderIcon = UIView()
    
    //MARK: Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        container.layer.cornerRadius = 18
        container.backgroundColor = UIColor.darkPurple()
        container.alpha = 1.0
        
        message.textColor = UIColor.whiteColor()
        message.font = UIFont.graphikRegular(16)
        message.backgroundColor = UIColor.clearColor()
        message.numberOfLines = 0
        message.lineBreakMode = .ByWordWrapping
        
        senderIcon.layer.cornerRadius = 15
        senderIcon.layer.borderColor = UIColor.whiteColor().CGColor
        senderIcon.layer.borderWidth = 1
        senderIcon.backgroundColor = UIColor.purple()
        
        addSubview(container)
        container.addSubview(message)
        addSubview(senderIcon)
    }
    
    func applyConstraints(){
        container.addConstraints(
            Constraint.lr.of(senderIcon, offset: 5),
            Constraint.rr.of(self, offset: -60),
            Constraint.ttbb.of(self, offset: 10)
        )
        
        message.addConstraints(
            Constraint.ttbb.of(container, offset: 11),
            Constraint.ll.of(container, offset: 11),
            Constraint.rr.of(container, offset: -11)
        )
        
        senderIcon.addConstraints(
            Constraint.bb.of(container),
            Constraint.ll.of(self, offset: 5),
            Constraint.wh.of(30)
        )
    }
}
