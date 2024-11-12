//
//  TimeView.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol TimeViewDelegate {
    optional func updateSelectedTimes(time: Int)
}

enum TimeState{
    case Unavailable
    case Unselected
    case Selected
}

class TimeView: UIView {
    
    //MARK: Properties
    var timeButton = UIButton()
    var selectedBackground = UIView()
    
    var delegate: TimeViewDelegate!
    var state = TimeState.Unselected
    var time = 0
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(cellTime: Int, timeDelegate: TimeViewDelegate){
        self.init(frame: CGRectZero)
        time = cellTime
        delegate = timeDelegate
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
        backgroundColor = UIColor.lightBlue()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimeView.handleTap))
        addGestureRecognizer(tap)
        
        timeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        timeButton.titleLabel?.font = UIFont.graphikRegular(20)
        
        timeButton.addTarget(self, action: #selector(TimeView.handleTap), forControlEvents: .TouchUpInside)
        
        selectedBackground.backgroundColor = UIColor.darkBlue()
        
        updateState()
        
        addSubview(selectedBackground)
        addSubview(timeButton)
    }
    
    func applyConstraints(){
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(timeSelectSize)
        )
        
        timeButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(timeSelectSize)
        )
    }
    
    func handleTap(){
        if state == .Unavailable{
            return
        }
        
        if selectedBackground.alpha == 0 {
            state = .Selected
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                self.timeButton.alpha = 1.0
                self.selectedBackground.alpha = 1.0
                self.selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
        }
        else {
            state = .Unselected
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                self.timeButton.alpha = 0.75
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
                }, completion: nil)
        }
        
        delegate.updateSelectedTimes?(time)
    }
    
    func updateState(){
        switch state {
        case .Unavailable:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.grayColor()
            selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            timeButton.alpha = 0.25
        case .Selected:
            selectedBackground.alpha = 1.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
            timeButton.alpha = 1.0
        case .Unselected:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            timeButton.alpha = 0.75
        }
    }
}




