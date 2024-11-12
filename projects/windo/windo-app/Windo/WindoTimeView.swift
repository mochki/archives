//
//  WindoTimeView.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoTimeView: UIView {
    
    //MARK: Properties
    var headerBackground = UIView()

    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.blue()
        headerBackground.backgroundColor = UIColor.lightBlue()
        addSubview(headerBackground)
    }
    
    func applyConstraints(){
        headerBackground.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(50)
        )
        
        sendSubviewToBack(headerBackground)
    }
}