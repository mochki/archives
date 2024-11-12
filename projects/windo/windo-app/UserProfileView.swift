//
//  UserProfileView.swift
//  Windo
//
//  Created by Joey on 6/2/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

enum ThemeColor {
    case Teal
    case Blue
    case Purple
}

class UserProfileView: UIView {
    
    //MARK: Properties
    var profileImage = WindoProfileImageView()
    var nameLabel = UILabel()
    var responseRating = UILabel()
    var addFriend = GHButton()
    
    var themeColor = ThemeColor.Teal
    
    //MARK: Inits
    convenience init(color: ThemeColor) {
        self.init(frame: CGRectZero)
        self.themeColor = color
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
        
        profileImage.layer.borderWidth = 2.0
        
        nameLabel.font = UIFont.graphikMedium(22)
        
        responseRating.text = "RESPONSE RATING: 87.5%"
        responseRating.font = UIFont.graphikRegular(12)
        
        addFriend.setTitle("Add Friend", forState: .Normal)
        addFriend.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addFriend.titleLabel?.font = UIFont.graphikRegular(15)
        addFriend.layer.cornerRadius = 6
        
        configureColors()
        
        addSubviews(profileImage, nameLabel, responseRating, addFriend)
    }
    
    func applyConstraints(){
        profileImage.addConstraints(
            Constraint.tt.of(self, offset: screenHeight * 0.075),
            Constraint.cxcx.of(self),
            Constraint.wh.of(150)
        )
        
        nameLabel.addConstraints(
            Constraint.tb.of(profileImage, offset: screenHeight * 0.033),
            Constraint.cxcx.of(self)
        )
        
        responseRating.addConstraints(
            Constraint.tb.of(nameLabel, offset: 2),
            Constraint.cxcx.of(self)
        )
        
        addFriend.addConstraints(
            Constraint.tb.of(responseRating,  offset: 15),
            Constraint.cxcx.of(self),
            Constraint.w.of(115),
            Constraint.h.of(28)
        )
    }
    
    func configureColors(){
        switch themeColor {
        case .Teal:
            backgroundColor = UIColor.lightTeal()
            profileImage.layer.borderColor = UIColor.mikeBlue().CGColor
            nameLabel.textColor = UIColor.mikeBlue()
            responseRating.textColor = UIColor.mikeBlue()
            addFriend.backgroundColor = UIColor.darkTeal()
            break
        case .Blue:
            backgroundColor = UIColor.lightBlue()
            profileImage.layer.borderColor = UIColor.darkBlue().CGColor
            nameLabel.textColor = UIColor.darkBlue()
            responseRating.textColor = UIColor.darkBlue()
            addFriend.backgroundColor = UIColor.darkBlue()
        case .Purple:
            backgroundColor = UIColor.lightPurple()
            profileImage.layer.borderColor = UIColor.darkPurple().CGColor
            nameLabel.textColor = UIColor.darkPurple()
            responseRating.textColor = UIColor.darkPurple()
            addFriend.backgroundColor = UIColor.darkPurple()
            
        }
    }
}







