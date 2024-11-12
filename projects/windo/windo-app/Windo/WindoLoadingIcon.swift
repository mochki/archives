//
//  WindoLoadingIcon.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoLoadingIcon: UIView {
    // MARK: Properties
    let container = UIView()
    let topLeft = UIView()
    let topRight = UIView()
    let bottomRight = UIView()
    let bottomLeft = UIView()
    
    internal var spacing:CGFloat = 6
    // MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }

    convenience init(spacing: CGFloat) {
        self.init()
        self.spacing = spacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews() {
        
        topLeft.backgroundColor = UIColor.whiteColor()
        topRight.backgroundColor = UIColor.whiteColor()
        bottomRight.backgroundColor = UIColor.whiteColor()
        bottomLeft.backgroundColor = UIColor.whiteColor()
        
        container.addSubviews(topLeft, topRight, bottomLeft, bottomRight)
        addSubview(container)
    }
    
    func applyConstraints() {
        container.addConstraints(
            Constraint.llrr.of(self),
            Constraint.ttbb.of(self)
        )
        
        topLeft.addConstraints(
            Constraint.tt.of(container),
            Constraint.ll.of(container),
            Constraint.rcx.of(container, offset: -spacing/2),
            Constraint.bcy.of(container, offset: -spacing/2)
        )
        
        topRight.addConstraints(
            Constraint.tt.of(container),
            Constraint.rr.of(container),
            Constraint.lcx.of(container, offset: spacing/2),
            Constraint.bcy.of(container, offset: -spacing/2)
        )
        
        bottomRight.addConstraints(
            Constraint.bb.of(container),
            Constraint.rr.of(container),
            Constraint.lcx.of(container, offset: spacing/2),
            Constraint.tcy.of(container, offset: spacing/2)
        )
        
        bottomLeft.addConstraints(
            Constraint.bb.of(container),
            Constraint.ll.of(container),
            Constraint.rcx.of(container, offset: -spacing/2),
            Constraint.tcy.of(container, offset: spacing/2)
        )
    }
}