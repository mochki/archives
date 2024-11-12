//
//  InviteeHeaderCell.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteeHeaderCell: UITableViewHeaderFooterView {
    
    //MARK: Properties
    var titleLabel = UILabel()
    
    //MARK: Inits
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.graphikRegular(12)
        addSubview(titleLabel)
    }
    
    func applyConstraints(){
        titleLabel.addConstraints(
            Constraint.ll.of(self, offset: 20),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(12)
        )
    }
}