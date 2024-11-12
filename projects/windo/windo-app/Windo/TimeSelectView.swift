//
//  TimeSelectView.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TimeSelectView: UIView {
    
    //MARK: Properties
    var scrubberCenter = UIView()
    var helpLabel = UILabel()
    var allDaysHelpLabel = UILabel()
    
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
        scrubberCenter.backgroundColor = UIColor.clearColor()
        
        helpLabel.text = "These are the times you \nand your invitees will choose from!"
        helpLabel.minimumScaleFactor = 0.5
        helpLabel.numberOfLines = 2
        helpLabel.textColor = UIColor.whiteColor()
        helpLabel.font = UIFont.graphikRegular(15)
        helpLabel.textAlignment = .Center
        
        allDaysHelpLabel.text = "Edit all your days,\nall at once!"
        allDaysHelpLabel.minimumScaleFactor = 0.5
        allDaysHelpLabel.numberOfLines = 2
        allDaysHelpLabel.textColor = UIColor.blue()
        allDaysHelpLabel.font = UIFont.graphikRegular(15)
        allDaysHelpLabel.textAlignment = .Center
        allDaysHelpLabel.alpha = 0.0
        
        addSubview(helpLabel)
        addSubview(allDaysHelpLabel)
        addSubview(scrubberCenter)
    }
    
    func applyConstraints(){
        let bottomOfTimes: CGFloat = 125 + (timeSelectSize * 4)
        
        scrubberCenter.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.wh.of(50)
        )
        
        helpLabel.addConstraints(
            Constraint.tt.of(self, offset: bottomOfTimes),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(30)
        )
        
        allDaysHelpLabel.addConstraints(
            Constraint.tt.of(self, offset: bottomOfTimes),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(30)
        )
    }

}








