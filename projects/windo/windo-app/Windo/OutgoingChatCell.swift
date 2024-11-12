//
//  OutgoingChatCell.swift
//  Windo
//
//  Created by Joey on 6/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class OutgoingChatCell: UITableViewCell {
    
    //MARK: Properties
    let container = UIView()
    let message = UILabel()
    
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
        
        message.textColor = UIColor.whiteColor()
        message.font = UIFont.graphikRegular(16)
        message.backgroundColor = UIColor.clearColor()
        message.numberOfLines = 0
        message.lineBreakMode = .ByWordWrapping
        
        addSubview(container)
        container.addSubview(message)
    }
    
    func applyConstraints(){
        container.addConstraints(
            Constraint.rr.of(self, offset: -10),
            Constraint.ll.of(self, offset: 60),
            Constraint.ttbb.of(self, offset: 10)
        )
        
        message.addConstraints(
            Constraint.ttbb.of(container, offset: 11),
            Constraint.ll.of(container, offset: 11),
            Constraint.rr.of(container, offset: -11)
        )
    }
}