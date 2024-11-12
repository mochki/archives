//
//  HomeView.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    //MARK: Properties
    var eventTableView = UITableView()
    var lowerBackgroundView = UIView()
    
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
        backgroundColor = UIColor.lightTeal()
        
        eventTableView.backgroundColor = UIColor.clearColor()
        eventTableView.showsVerticalScrollIndicator = false
        eventTableView.separatorColor = UIColor.mikeBlue(0.34)
        eventTableView.registerClass(EventCell.self, forCellReuseIdentifier: "eventCell")
        eventTableView.registerClass(EventHeaderCell.self, forHeaderFooterViewReuseIdentifier: "eventHeaderCell")
        
        lowerBackgroundView.backgroundColor = UIColor.darkTeal()
        
        clipsToBounds = false
        
        addSubview(lowerBackgroundView)
        addSubview(eventTableView)
    }
    
    func applyConstraints(){
        lowerBackgroundView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.bb.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight/2)
        )
        
        eventTableView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tt.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 64)
        )
    }
}
