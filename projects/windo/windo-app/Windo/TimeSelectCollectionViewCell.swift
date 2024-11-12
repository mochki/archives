//
//  TimeSelectCollectionViewCell.swift
//  Windo
//
//  Created by Joey on 4/7/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol TimeSelectCollectionViewCellDelegate {
    optional func updateSelectedTimes(date: NSDate, time: Int)
}

class TimeSelectCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    var date = NSDate()
    var delegate: TimeSelectCollectionViewCellDelegate!
    var initialStates = [CGFloat]()
    
    var amContainer = UIView()
    var pmContainer = UIView()
    var dragView = UIView()
    
    var amLabel = UILabel()
    var pmLabel = UILabel()
    
    //times
    var times = [TimeView]()
    var timesConfigured = false
    
    var time0 = TimeView()
    var time1 = TimeView()
    var time2 = TimeView()
    var time3 = TimeView()
    var time4 = TimeView()
    var time5 = TimeView()
    var time6 = TimeView()
    var time7 = TimeView()
    var time8 = TimeView()
    var time9 = TimeView()
    var time10 = TimeView()
    var time11 = TimeView()
    var time12 = TimeView()
    var time13 = TimeView()
    var time14 = TimeView()
    var time15 = TimeView()
    var time16 = TimeView()
    var time17 = TimeView()
    var time18 = TimeView()
    var time19 = TimeView()
    var time20 = TimeView()
    var time21 = TimeView()
    var time22 = TimeView()
    var time23 = TimeView()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Configuration
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for time in times {
            time.state = TimeState.Unselected
            time.updateState()
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.clearColor()
        
        times = [time0, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23]
        configureTimes()
        
        amLabel.text = "AM"
        amLabel.textColor = UIColor.whiteColor()
        amLabel.font = UIFont.graphikRegular(10)
        amLabel.textAlignment = .Center
        
        pmLabel.text = "PM"
        pmLabel.textColor = UIColor.whiteColor()
        pmLabel.font = UIFont.graphikRegular(10)
        pmLabel.textAlignment = .Center
        
        amContainer.backgroundColor = UIColor.darkBlue()
        pmContainer.backgroundColor = UIColor.darkBlue()
        dragView.backgroundColor = UIColor.clearColor()
        
        time0.backgroundColor = UIColor.fromHex(0x6587FF)
        time1.backgroundColor = UIColor.fromHex(0x6587FF)
        time2.backgroundColor = UIColor.fromHex(0x6587FF)
        time3.backgroundColor = UIColor.fromHex(0x6587FF)
        time4.backgroundColor = UIColor.fromHex(0x6587FF)
        time5.backgroundColor = UIColor.fromHex(0x6587FF)
        
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(TimeSelectCollectionViewCell.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(TimeSelectCollectionViewCell.handleCalendarGesture(_:)))

        dragView.addGestureRecognizer(drag)
        dragView.addGestureRecognizer(tap)

        
        addSubview(amContainer)
        addSubview(pmContainer)
        addSubviews(time0, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, time11, time12, time13, time14, time15, time16, time17, time18, time19, time20, time21, time22, time23)
        addSubview(amLabel)
        addSubview(pmLabel)
        
        addSubview(dragView)
    }
    
    func configureTimes(){
        var timeCount = 0
        
        for time in times {
                    
            if timeCount > 12 {
                time.timeButton.setTitle("\(timeCount - 12)", forState: .Normal)
            }
            else if timeCount == 0 {
                time.timeButton.setTitle("\(12)", forState: .Normal)
            }
            else {
                time.timeButton.setTitle("\(timeCount)", forState: .Normal)
            }
            time.delegate = self
            time.time = timeCount
            timeCount += 1
        }
    }
    
    func applyConstraints(){
        let timeBuffer = (screenWidth - (timeSelectSize * 6) - 5)/2
        
        dragView.addConstraints(
            Constraint.tt.of(amContainer),
            Constraint.ll.of(amContainer),
            Constraint.w.of(timeSelectSize * 6 + 7),
            Constraint.h.of(timeSelectSize * 4 + 16)
        )
        
        amContainer.addConstraints(
            Constraint.tt.of(self, offset: 55),
            Constraint.ll.of(self, offset: timeBuffer),
            Constraint.w.of(timeSelectSize * 6 + 7),
            Constraint.h.of(timeSelectSize * 1 + 2)
        )
        
        pmContainer.addConstraints(
            Constraint.tb.of(amContainer, offset: 10),
            Constraint.ll.of(self, offset: timeBuffer),
            Constraint.w.of(timeSelectSize * 6 + 7),
            Constraint.h.of(timeSelectSize * 3 + 4)
        )
        
        amLabel.addConstraints(
            Constraint.tt.of(time0, offset: 2),
            Constraint.ll.of(time0, offset: 2),
            Constraint.w.of(17)
        )
        
        pmLabel.addConstraints(
            Constraint.tt.of(time12, offset: 2),
            Constraint.ll.of(time12, offset: 2),
            Constraint.w.of(17)
        )
        
        //am row 1
        time0.addConstraints(
            Constraint.tt.of(amContainer, offset: 1),
            Constraint.ll.of(amContainer, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time1.addConstraints(
            Constraint.cycy.of(time0),
            Constraint.lr.of(time0, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time2.addConstraints(
            Constraint.cycy.of(time0),
            Constraint.lr.of(time1, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time3.addConstraints(
            Constraint.cycy.of(time0),
            Constraint.lr.of(time2, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time4.addConstraints(
            Constraint.cycy.of(time0),
            Constraint.lr.of(time3, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time5.addConstraints(
            Constraint.cycy.of(time0),
            Constraint.lr.of(time4, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        //am row 2
        time6.addConstraints(
            Constraint.tt.of(pmContainer, offset: 1),
            Constraint.ll.of(pmContainer, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time7.addConstraints(
            Constraint.cycy.of(time6),
            Constraint.lr.of(time6, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time8.addConstraints(
            Constraint.cycy.of(time6),
            Constraint.lr.of(time7, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time9.addConstraints(
            Constraint.cycy.of(time6),
            Constraint.lr.of(time8, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time10.addConstraints(
            Constraint.cycy.of(time6),
            Constraint.lr.of(time9, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time11.addConstraints(
            Constraint.cycy.of(time6),
            Constraint.lr.of(time10, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        //pm row 1
        time12.addConstraints(
            Constraint.tb.of(time6, offset: 1),
            Constraint.ll.of(time0),
            Constraint.wh.of(timeSelectSize)
        )
        
        time13.addConstraints(
            Constraint.cycy.of(time12),
            Constraint.lr.of(time12, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time14.addConstraints(
            Constraint.cycy.of(time12),
            Constraint.lr.of(time13, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time15.addConstraints(
            Constraint.cycy.of(time12),
            Constraint.lr.of(time14, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time16.addConstraints(
            Constraint.cycy.of(time12),
            Constraint.lr.of(time15, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time17.addConstraints(
            Constraint.cycy.of(time12),
            Constraint.lr.of(time16, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        //pm row 2
        time18.addConstraints(
            Constraint.tb.of(time12, offset: 1),
            Constraint.ll.of(time12),
            Constraint.wh.of(timeSelectSize)
        )
        
        time19.addConstraints(
            Constraint.cycy.of(time18),
            Constraint.lr.of(time18, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time20.addConstraints(
            Constraint.cycy.of(time18),
            Constraint.lr.of(time19, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time21.addConstraints(
            Constraint.cycy.of(time18),
            Constraint.lr.of(time20, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time22.addConstraints(
            Constraint.cycy.of(time18),
            Constraint.lr.of(time21, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
        
        time23.addConstraints(
            Constraint.cycy.of(time18),
            Constraint.lr.of(time22, offset: 1),
            Constraint.wh.of(timeSelectSize)
        )
    }
    
    func handleCalendarGesture(gesture: UIGestureRecognizer){
        if initialStates.isEmpty {
            for time in times {
                initialStates.append(time.selectedBackground.alpha)
            }
        }
        
        for (index,time) in times.enumerate() {
            if time.frame.contains(gesture.locationInView(contentView)){
                if (time.selectedBackground.alpha == initialStates[index]){
                    time.handleTap()
                }
            }
        }
        if gesture.state == .Ended {
            initialStates.removeAll()
        }
    }
    
    func updateTimesStates(selectedIndices: [Int]){
        for index in selectedIndices {
            times[index].state = .Selected
            times[index].updateState()
        }
    }
}

extension TimeSelectCollectionViewCell: TimeViewDelegate {
    func updateSelectedTimes(time: Int) {
        delegate.updateSelectedTimes!(date, time: time)
    }
}

