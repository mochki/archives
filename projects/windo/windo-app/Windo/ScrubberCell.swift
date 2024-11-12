//
//  ScrubberCell.swift
//  Windo
//
//  Created by Joey on 4/7/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ScrubberCell: UICollectionViewCell {
    
    //MARK: Properties
    var dateLabel = UILabel()
    var dayOfTheWeekLabel = UILabel()
    var allDaysLabel = UILabel()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
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
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.font = UIFont.graphikRegular(12)
        dateLabel.textAlignment = .Center
        
        dayOfTheWeekLabel.textColor = UIColor.whiteColor()
        dayOfTheWeekLabel.font = UIFont.graphikMedium(16)
        dayOfTheWeekLabel.textAlignment = .Center
        
        allDaysLabel.textColor = UIColor.whiteColor()
        allDaysLabel.font = UIFont.graphikMedium(16)
        allDaysLabel.textAlignment = .Center
        allDaysLabel.text = "ALL\nDAYS"
        allDaysLabel.numberOfLines = 2
        allDaysLabel.alpha = 0.0
        
        addSubview(dateLabel)
        addSubview(dayOfTheWeekLabel)
        addSubview(allDaysLabel)
    }

    func applyConstraints(){
        dateLabel.addConstraints(
            Constraint.tt.of(self, offset: 10),
            Constraint.cxcx.of(self)
        )
        
        dayOfTheWeekLabel.addConstraints(
            Constraint.tb.of(dateLabel, offset: 3),
            Constraint.cxcx.of(self)
        )
        
        allDaysLabel.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(self)
        )
    }
    
    func fadeOut(){
        if allDaysLabel.alpha == 0.0 {
            UIView.animateWithDuration(0.1, animations: {
                self.dateLabel.alpha = 0.5
                self.dayOfTheWeekLabel.alpha = 0.5
            })
        }
        else {
            UIView.animateWithDuration(0.1, animations: {
                self.allDaysLabel.alpha = 0.5
            })
        }
    }
    
    func fadeIn(){
        if allDaysLabel.alpha == 0.0 {
            UIView.animateWithDuration(0.1, animations: {
                self.dateLabel.alpha = 1.0
                self.dayOfTheWeekLabel.alpha = 1.0
            })
        }
        else {
            UIView.animateWithDuration(0.1, animations: {
                self.allDaysLabel.alpha = 1.0
            })
        }
    }
}
