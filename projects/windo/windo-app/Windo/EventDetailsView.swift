//
//  EventDetailsView.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventDetailsView: UIView {
    
    //MARK: Properties
    
    //response report – Responses will be added dynamically with real data
    var respondedStackView = UIStackView()
    var response1 = ResponseCircleView()
    var response2 = ResponseCircleView()
    var response3 = ResponseCircleView()
    var response4 = ResponseCircleView()
    var responseStatus = UILabel()
    
    //response needed
    var responseLabel = UILabel()
    var anytimeWorks = GHButton()
    var submitTimes = GHButton()
    var blurView = UIView()
    
    //location/date+time
    var separatingLine = UIView()
    var locationTitleLabel = UILabel()
    var locationLabel = UILabel()
    var dateTimeTitleLabel = UILabel()
    var dateTimeLabel = UILabel()
    
    //group members
    var addMemberCell = UIView()
    var addMemberLabel = UILabel()
    var addMemberButton = UIButton()
    var memberTableView = UITableView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
//        backgroundColor = UIColor.lightPurple()
        
        respondedStackView = UIStackView(arrangedSubviews: [response1, response2, response3, response4])
        respondedStackView.axis = .Horizontal
        respondedStackView.distribution = .EqualSpacing
        respondedStackView.spacing = 10
        
        response1.initials.text = "JN"
        response2.initials.text = "SK"
        response3.initials.text = "YD"
        response4.initials.text = "RE"
        response3.alpha = 0.18
        
        responseStatus.text = "3/4 have responded!"
        responseStatus.textColor = UIColor.darkPurple()
        responseStatus.alpha = 0.44
        responseStatus.font = UIFont.graphikRegular(12)
        responseStatus.textAlignment = .Center
        
        separatingLine.backgroundColor = UIColor.darkPurple()
        
        locationTitleLabel.text = "Location"
        locationTitleLabel.textColor = UIColor.darkPurple()
        locationTitleLabel.font = UIFont.graphikRegular(12)
        locationTitleLabel.textAlignment = .Center
        
        locationLabel.text = "Yellow Door House\n346 N 400 E Provo,UT"
        locationLabel.numberOfLines = 3
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        locationLabel.font = UIFont.graphikRegular(14)
        
        dateTimeTitleLabel.text = "Date + Time"
        dateTimeTitleLabel.textColor = UIColor.darkPurple()
        dateTimeTitleLabel.font = UIFont.graphikRegular(12)
        dateTimeTitleLabel.textAlignment = .Center
        
        dateTimeLabel.text = "September 17, 2016\n7:00 P.M."
        dateTimeLabel.numberOfLines = 3
        dateTimeLabel.textColor = UIColor.whiteColor()
        dateTimeLabel.textAlignment = .Center
        dateTimeLabel.font = UIFont.graphikRegular(14)
        
        addMemberCell.layer.borderColor = UIColor.purple().CGColor
        addMemberCell.layer.borderWidth = 1.0
        addMemberCell.backgroundColor = UIColor.lightPurple()
        
        addMemberLabel.text = "Group Members"
        addMemberLabel.textColor = UIColor.darkPurple()
        addMemberLabel.font = UIFont.graphikRegular(16)
        
        addMemberButton.setImage(UIImage(named: "AddMemberButton"), forState: .Normal)
        
        memberTableView.backgroundColor = UIColor.purple()
        memberTableView.showsVerticalScrollIndicator = false
        memberTableView.separatorColor = UIColor.darkPurple(0.7)
        memberTableView.allowsSelection = false
        memberTableView.registerClass(GroupMemberCell.self, forCellReuseIdentifier: "memberCell")
        
        responseLabel.text = "Submit your available times!"
        responseLabel.textColor = UIColor.darkPurple()
        responseLabel.textAlignment = .Center
        responseLabel.font = UIFont.graphikRegular(14)
        
        anytimeWorks.setTitle("Anytime Works", forState: .Normal)
        anytimeWorks.setTitleColor(UIColor.darkPurple(), forState: .Normal)
        anytimeWorks.titleLabel?.font = UIFont.graphikRegular(18)
        anytimeWorks.layer.borderColor = UIColor.darkPurple().CGColor
        anytimeWorks.layer.borderWidth = 1.25
        anytimeWorks.layer.cornerRadius = 5.0
        
        submitTimes.setTitle("Submit Times", forState: .Normal)
        submitTimes.setTitleColor(UIColor.darkPurple(), forState: .Normal)
        submitTimes.titleLabel?.font = UIFont.graphikRegular(18)
        submitTimes.layer.borderColor = UIColor.darkPurple().CGColor
        submitTimes.layer.borderWidth = 1.25
        submitTimes.layer.cornerRadius = 5.0
        
        blurView.backgroundColor = UIColor.blackColor()
        blurView.alpha = 0.8
                
        addSubview(respondedStackView)
        addSubview(responseStatus)
        addSubview(separatingLine)
        addSubview(dateTimeTitleLabel)
        addSubview(dateTimeLabel)
        addSubview(locationTitleLabel)
        addSubview(locationLabel)
        addSubview(addMemberCell)
        addSubview(addMemberLabel)
        addSubview(addMemberButton)
        addSubview(memberTableView)
        addSubviews(responseLabel, anytimeWorks, submitTimes, blurView)
    }
    
    func applyConstraints(){
        respondedStackView.addConstraints(
            Constraint.tt.of(self, offset: 18),
            Constraint.cxcx.of(self),
            Constraint.w.of(44*4),
            Constraint.h.of(40)
        )
        
        responseStatus.addConstraints(
            Constraint.tb.of(respondedStackView, offset: 16),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(12)
        )
        
        separatingLine.addConstraints(
            Constraint.tb.of(responseStatus, offset: 27),
            Constraint.cxcx.of(self),
            Constraint.w.of(1.2),
            Constraint.h.of(62))
        
        dateTimeTitleLabel.addConstraints(
            Constraint.tt.of(separatingLine),
            Constraint.cxcx.of(self, offset: screenWidth * 0.25),
            Constraint.w.of(screenWidth/2),
            Constraint.h.of(13))
        
        dateTimeLabel.addConstraints(
            Constraint.tb.of(dateTimeTitleLabel, offset: 6),
            Constraint.cxcx.of(self, offset: screenWidth * 0.25),
            Constraint.w.of(screenWidth/2),
            Constraint.h.of(32))
        
        locationTitleLabel.addConstraints(
            Constraint.tt.of(separatingLine),
            Constraint.cxcx.of(self, offset: -(screenWidth * 0.25)),
            Constraint.w.of(screenWidth/2),
            Constraint.h.of(13))
        
        locationLabel.addConstraints(
            Constraint.tb.of(locationTitleLabel, offset: 6),
            Constraint.cxcx.of(self, offset: -(screenWidth * 0.25)),
            Constraint.w.of(screenWidth/2),
            Constraint.h.of(32))
        
        addMemberCell.addConstraints(
            Constraint.tb.of(separatingLine, offset: 22),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth + 2),
            Constraint.h.of(53))
        
        addMemberLabel.addConstraints(
            Constraint.cycy.of(addMemberCell),
            Constraint.ll.of(addMemberCell, offset: 19),
            Constraint.w.of(200),
            Constraint.h.of(20))
        
        addMemberButton.addConstraints(
            Constraint.cycy.of(addMemberCell),
            Constraint.rr.of(addMemberCell, offset: -25),
            Constraint.w.of(30),
            Constraint.h.of(30))
        
        memberTableView.addConstraints(
            Constraint.tb.of(addMemberCell),
            Constraint.llrr.of(self),
            Constraint.bb.of(self)
        )
        //TODO: This is constrainted behind the tab bar, find a dynamic way to constrain this when the tab bar is/isn't hidden
        
        
        responseLabel.addConstraints(
            Constraint.tb.of(responseStatus, offset: 25),
            Constraint.cxcx.of(self)
        )
        
        anytimeWorks.addConstraints(
            Constraint.tb.of(responseLabel, offset: 15),
            Constraint.rcx.of(self, offset: -15),
            Constraint.w.of(screenWidth/2 - 50),
            Constraint.h.of(40)
        )
        
        submitTimes.addConstraints(
            Constraint.tb.of(responseLabel, offset: 15),
            Constraint.lcx.of(self, offset: 15),
            Constraint.w.of(screenWidth/2 - 50),
            Constraint.h.of(40)
        )
        
        blurView.addConstraints(
            Constraint.tt.of(addMemberCell),
            Constraint.bb.of(self),
            Constraint.llrr.of(self)
        )
    }
}

class ResponseCircleView: UIView {
    
    //MARK: Properties
    var initials = UILabel()
    var backgroundView = UIView()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundView.backgroundColor = UIColor.darkPurple(0.46)
        backgroundView.layer.cornerRadius = 17
        
        initials.font = UIFont.graphikRegular(14)
        initials.textColor = UIColor.whiteColor()
        initials.textAlignment = .Center
        
        addSubview(backgroundView)
        addSubview(initials)
    }
    
    func applyConstraints(){
        
        initials.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(34),
            Constraint.h.of(34))
        
        backgroundView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(34),
            Constraint.h.of(34))
    }
}




