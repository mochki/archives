//
//  SideMenuView.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class SideMenuView: UIView {
    
    //MARK: Properties
    var tutorialButton = GHButton()
    
    var profileImage = WindoProfileImageView()
    var nameLabel = UILabel()
    var responseRating = UILabel()
    var inviteFriends = GHButton()
    var searchPeople = GHButton()
    var help = GHButton()
    var settings = GHButton()
    var signOut = GHButton()
    
    var windoLabel = UILabel()
    var versionLabel = UILabel()
    
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
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        profileImage.layer.borderColor = UIColor.mikeBlue().CGColor
        profileImage.layer.borderWidth = 2.0
        
        nameLabel.textColor = UIColor.mikeBlue()
        nameLabel.font = UIFont.graphikMedium(22)
        
        responseRating.text = "RESPONSE RATING: 87.5%"
        responseRating.textColor = UIColor.mikeBlue()
        responseRating.font = UIFont.graphikRegular(12)
        
        inviteFriends.setTitle("Invite Friends", forState: .Normal)
        inviteFriends.setTitleColor(UIColor.mikeBlue(), forState: .Normal)
        inviteFriends.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        inviteFriends.titleLabel?.font = UIFont.graphikRegular(18)
        
        searchPeople.setTitle("Search People", forState: .Normal)
        searchPeople.setTitleColor(UIColor.mikeBlue(), forState: .Normal)
        searchPeople.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        searchPeople.titleLabel?.font = UIFont.graphikRegular(18)
        
        help.setTitle("Help", forState: .Normal)
        help.setTitleColor(UIColor.mikeBlue(), forState: .Normal)
        help.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        help.titleLabel?.font = UIFont.graphikRegular(18)
        
        settings.setTitle("Settings", forState: .Normal)
        settings.setTitleColor(UIColor.mikeBlue(), forState: .Normal)
        settings.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        settings.titleLabel?.font = UIFont.graphikRegular(18)
        
        signOut.setTitle("Sign Out", forState: .Normal)
        signOut.setTitleColor(UIColor.mikeBlue(), forState: .Normal)
        signOut.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        signOut.titleLabel?.font = UIFont.graphikRegular(18)
        
        windoLabel.text = "windo"
        windoLabel.textColor = UIColor.whiteColor()
        windoLabel.font = UIFont.graphikMedium(22)
        windoLabel.textAlignment = .Center
        
        versionLabel.text = "V 1.0"
        versionLabel.textColor = UIColor.whiteColor()
        versionLabel.font = UIFont.graphikRegular(14)
        versionLabel.textAlignment = .Center
        
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(responseRating)
        addSubview(inviteFriends)
        addSubview(searchPeople)
        addSubview(help)
        addSubview(settings)
        addSubview(signOut)
        
        addSubview(windoLabel)
        addSubview(versionLabel)
    }
    
    func applyConstraints(){
        profileImage.addConstraints(
            Constraint.tt.of(self, offset: screenHeight * 0.15),
            Constraint.ll.of(self, offset: screenWidth * 0.09),
            Constraint.wh.of(90)
        )
        
        nameLabel.addConstraints(
            Constraint.tb.of(profileImage, offset: screenHeight * 0.033),
            Constraint.ll.of(profileImage)
        )
        
        responseRating.addConstraints(
            Constraint.tb.of(nameLabel, offset: 2),
            Constraint.ll.of(profileImage)
        )
        
        inviteFriends.addConstraints(
            Constraint.tb.of(nameLabel, offset: screenHeight * 0.12),
            Constraint.ll.of(profileImage),
            Constraint.h.of(20)
        )
        
        searchPeople.addConstraints(
            Constraint.tb.of(inviteFriends, offset: 12),
            Constraint.ll.of(profileImage),
            Constraint.h.of(20)
        )
        
        help.addConstraints(
            Constraint.tb.of(searchPeople, offset: 12),
            Constraint.ll.of(profileImage),
            Constraint.h.of(20)
        )
        
        settings.addConstraints(
            Constraint.tb.of(help, offset: 12),
            Constraint.ll.of(profileImage),
            Constraint.h.of(20)
        )
        
        signOut.addConstraints(
            Constraint.tb.of(settings, offset: 24),
            Constraint.ll.of(profileImage),
            Constraint.h.of(20)
        )
        
        windoLabel.addConstraints(
            Constraint.bb.of(self, offset: -20),
            Constraint.cxcx.of(self, offset: -centerPanelExpandedOffset/2)
        )
        
        versionLabel.addConstraints(
            Constraint.tb.of(windoLabel),
            Constraint.cxcx.of(windoLabel)
        )
    }
}