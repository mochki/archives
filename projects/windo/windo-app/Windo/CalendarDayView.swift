//
//  CalendarDayView.swift
//  Windo
//
//  Created by Joey on 3/23/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol CalendarDayDelegate {
    optional func updateSelectedDays(dayNumber: Int)
}

enum DayState{
    case Past
    case Unselected
    case Selected
    case Empty
}

class CalendarDayView: UIView {
    
    //MARK: Properties
    var delegate: CalendarDayDelegate!
    var state = DayState.Empty
    
    var selectedBackground = UIView()
    var dateButton = UIButton()
    
    var day = 0
    var date: NSDate!
    
    
    //MARK: Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(dayNumber: Int, cellDate: NSDate){
        self.init(frame: CGRectZero)
        day = dayNumber
        date = cellDate
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
        backgroundColor = UIColor.blue()
        
        dateButton.setTitle("\(day)", forState: .Normal)
        dateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        dateButton.alpha = 0.75
        dateButton.titleLabel?.font = UIFont.graphikRegular(18)
        dateButton.addTarget(self, action: #selector(CalendarDayView.tapped), forControlEvents: .TouchUpInside)
        
        updateState()
        
        addSubview(selectedBackground)
        addSubview(dateButton)
    }
    
    func applyConstraints(){
        let daySize: CGFloat = (screenWidth - 8)/7
        
        selectedBackground.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
        
        dateButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(daySize)
        )
    }
    
    func tapped(){
        if state == .Empty || state == .Past{
            return
        }
        
        if selectedBackground.alpha == 0 {
            state = .Selected
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                    self.dateButton.alpha = 1.0
                    self.selectedBackground.alpha = 1.0
                    self.selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
        }
        else {
            state = .Unselected
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { void in
                self.dateButton.alpha = 0.75
                self.selectedBackground.alpha = 0.0
                self.selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
                }, completion: nil)
        }
        
        delegate.updateSelectedDays!(day)
    }
    
    func updateState(){
        switch state {
        case .Past:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.grayColor()
            selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            dateButton.alpha = 0.25
        case .Selected:
            selectedBackground.alpha = 1.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransformMakeScale(1.0, 1.0)
            dateButton.alpha = 1.0
        case .Unselected:
            selectedBackground.alpha = 0.0
            selectedBackground.backgroundColor = UIColor.darkBlue()
            selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            dateButton.alpha = 0.75
        case .Empty:
            dateButton.setTitle("", forState: .Normal)
            selectedBackground.alpha = 0.0
            selectedBackground.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            dateButton.alpha = 0.0
            layer.borderWidth = 0
            return
        }
        
        guard let _ = date else { return }
        let today = NSDate()
        if date.fullDate() == today.fullDate() {
            layer.borderColor = UIColor.whiteColor().CGColor
            layer.borderWidth = 1.0
        }
        else {
            layer.borderColor = UIColor.clearColor().CGColor
            layer.borderWidth = 0.0
        }
    }
}