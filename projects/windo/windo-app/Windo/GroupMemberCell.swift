//
//  GroupMemberCell.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {
    
    //MARK: Properties
    var nameLabel = UILabel()
    var initialsIcon = UIView()
    var initialsLabel = UILabel()
    var infoButton = UIButton()
    var infoGestureContainer = UIView()
    var infoGestureRecognizer = UITapGestureRecognizer()
    
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
        backgroundColor = UIColor.purple()
        
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.graphikRegular(16)
        
        infoButton.setImage(UIImage(named: "InfoButton"), forState: .Normal)
        
        initialsIcon.layer.borderWidth = 1.2
        initialsIcon.layer.borderColor = UIColor.whiteColor().CGColor
        initialsIcon.layer.cornerRadius = 22
        
        initialsLabel.textColor = UIColor.whiteColor()
        initialsLabel.textAlignment = .Center
        initialsLabel.font = UIFont.graphikRegular(19)
        
        addSubview(nameLabel)
        addSubview(initialsIcon)
        addSubview(initialsLabel)
        addSubview(infoButton)
        addSubview(infoGestureContainer)
        infoGestureContainer.addGestureRecognizer(infoGestureRecognizer)
    }
    
    func applyConstraints(){
        initialsIcon.addConstraints(
            Constraint.ll.of(self, offset: 24),
            Constraint.cycy.of(self),
            Constraint.wh.of(44)
        )
        
        initialsLabel.addConstraints(
            Constraint.cxcx.of(initialsIcon),
            Constraint.cycy.of(initialsIcon),
            Constraint.wh.of(44)
        )
        
        nameLabel.addConstraints(
            Constraint.lr.of(initialsIcon, offset: 17),
            Constraint.cycy.of(self)
        )
        
        infoButton.addConstraints(
            Constraint.rr.of(self, offset: -27),
            Constraint.cycy.of(self),
            Constraint.wh.of(23)
        )
        
        infoGestureContainer.addConstraints(
            Constraint.rr.of(self),
            Constraint.cycy.of(self),
            Constraint.h.of(65),
            Constraint.w.of(50)
        )
    }
}