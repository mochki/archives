//
//  TutorialView.swift
//  Windo
//
//  Created by Joey on 4/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    
    //MARK: Properties
    
    var mainScrollView = UIScrollView()
    var mainView = UIView()
    var xButton = UIButton()
    
    var circles = ConnectingCirclesView()
    
    var tealView = UIView()
    var blueView = UIView()
    var purpleView = UIView()
    
    //teal
    var tealLabel = UILabel()
    
    //blue
    var blueLabel = UILabel()
    
    //purple
    var purpleLabel = UILabel()
    
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
        mainScrollView.contentSize = CGSizeMake(screenWidth * 3, screenHeight)
        mainScrollView.pagingEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = mainView.backgroundColor
        
        mainView.backgroundColor = UIColor.teal()
        
        xButton.setTitle("X", forState: .Normal)
        xButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        xButton.titleLabel?.font = UIFont.graphikRegular(25)
        
        //Teal View
        tealView.backgroundColor = UIColor.clearColor()
        tealLabel.text = "Hey! I'm Teal"
        tealLabel.textColor = UIColor.whiteColor()
        tealLabel.font = UIFont.graphikRegular(18)
        tealLabel.textAlignment = .Center
        
        //Blue View
        blueView.backgroundColor = UIColor.clearColor()
        blueLabel.text = "And I'm Blue"
        blueLabel.textColor = UIColor.whiteColor()
        blueLabel.font = UIFont.graphikRegular(18)
        blueLabel.textAlignment = .Center
        
        //Purple View
        purpleView.backgroundColor = UIColor.clearColor()
        purpleLabel.text = "But I'm Purple"
        purpleLabel.textColor = UIColor.whiteColor()
        purpleLabel.font = UIFont.graphikRegular(18)
        purpleLabel.textAlignment = .Center
        
        addSubview(mainScrollView)
        addSubview(xButton)
        addSubview(circles)
        
        mainScrollView.addSubview(mainView)
        mainView.addSubview(tealView)
        tealView.addSubview(tealLabel)
        
        mainView.addSubview(blueView)
        blueView.addSubview(blueLabel)
        
        mainView.addSubview(purpleView)
        purpleView.addSubview(purpleLabel)
    }
    
    func applyConstraints(){
        mainScrollView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
        
        xButton.addConstraints(
            Constraint.tt.of(self, offset: 15),
            Constraint.ll.of(self, offset: 15),
            Constraint.wh.of(30)
        )
        
        circles.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.bb.of(self, offset: -20),
            Constraint.w.of(circles.circleViewWidth),
            Constraint.h.of(circles.circleWidth)
        )
        
        mainView.addConstraints(
            Constraint.tt.of(mainScrollView),
            Constraint.ll.of(mainScrollView),
            Constraint.w.of(screenWidth * 3),
            Constraint.h.of(screenHeight)
        )
        
        tealView.addConstraints(
            Constraint.tt.of(mainView),
            Constraint.ll.of((mainView)),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
        
        tealLabel.addConstraints(
            Constraint.bb.of(tealView, offset: -55),
            Constraint.cxcx.of(tealView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(20)
        )
        
        blueView.addConstraints(
            Constraint.cycy.of((mainView)),
            Constraint.lr.of(tealView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
        
        blueLabel.addConstraints(
            Constraint.bb.of(blueView, offset: -55),
            Constraint.cxcx.of(blueView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(20)
        )
        
        purpleView.addConstraints(
            Constraint.cycy.of((mainView)),
            Constraint.lr.of(blueView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight)
        )
        
        purpleLabel.addConstraints(
            Constraint.bb.of(purpleView, offset: -55),
            Constraint.cxcx.of(purpleView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(20)
        )
    }
}
