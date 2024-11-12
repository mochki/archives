//
//  LoginView.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    //MARK: Properties
    var windoLabel = UILabel()
    var facebookButton = GHButton()
    
    let loginButton = FBSDKLoginButton()
    
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
        
        windoLabel.text = "windo"
        windoLabel.textColor = UIColor.whiteColor()
        windoLabel.font = UIFont.graphikRegular(35)
                
        facebookButton.layer.borderColor = UIColor.whiteColor().CGColor
        facebookButton.layer.borderWidth = 1
        facebookButton.setTitle("SIGN IN WITH FACEBOOK", forState: .Normal)
        facebookButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        facebookButton.titleLabel?.font = UIFont.graphikMedium(13)
        facebookButton.titleLabel?.textAlignment = .Left
                
        addSubview(windoLabel)
        addSubview(facebookButton)
        addSubview(loginButton)
    }
    
    func applyConstraints(){
        windoLabel.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self, offset: -screenHeight/4)
        )
        
        facebookButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self, offset: -25),
            Constraint.w.of(200),
            Constraint.h.of(35)
        )
        
        loginButton.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.tb.of(self, offset: 25),
            Constraint.w.of(200),
            Constraint.h.of(35)
        )
    }
}
