//
//  HomeTableViewCell.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    //MARK: Properties
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var eventStatus = UILabel()
    var arrowImageView = UIImageView()
    var notificationDot = NotificationDotView()
    
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
        
        titleLabel.textColor = UIColor.mikeBlue()
        titleLabel.font = UIFont.graphikRegular(22)
        
        locationLabel.textColor = UIColor.mikeBlue()
        locationLabel.font = UIFont.graphikRegular(18)
        
        eventStatus.font = UIFont.graphikRegular(16)
        
        arrowImageView.image = UIImage(named: "CellArrow")
        
        notificationDot.backgroundColor = UIColor.whiteColor()
        notificationDot.layer.cornerRadius = 5
        
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(eventStatus)
        addSubview(arrowImageView)
        addSubview(notificationDot)
    }
    
    func applyConstraints(){
        titleLabel.addConstraints(
            Constraint.ll.of(self, offset: 39),
            Constraint.tt.of(self, offset: 27)
        )
        
        locationLabel.addConstraints(
            Constraint.ll.of(titleLabel),
            Constraint.tb.of(titleLabel, offset: 3)
        )
        
        eventStatus.addConstraints(
            Constraint.ll.of(titleLabel),
            Constraint.tb.of(locationLabel, offset: 22)
        )
        
        arrowImageView.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self, offset: -22)
        )
        
        notificationDot.addConstraints(
            Constraint.rl.of(titleLabel, offset: -12),
            Constraint.cycy.of(titleLabel),
            Constraint.wh.of(10)
        )
    }
}

class NotificationDotView: UIView {
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(color: UIColor) {
        self.init(frame: CGRectZero)
        self.backgroundColor = color
        self.layer.cornerRadius = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
