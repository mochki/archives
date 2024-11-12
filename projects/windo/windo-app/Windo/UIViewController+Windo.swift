//
//  UIViewController+Windo.swift
//  Windo
//
//  Created by Joey on 6/10/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSplashScreen(mainView: UIView) {
        let splashScreen = SplashScreenView()
        mainView.addSubview(splashScreen)
        
        splashScreen.addConstraints(
            Constraint.ttbb.of(mainView),
            Constraint.llrr.of(mainView)
        )
        
        mainView.setNeedsLayout()
    }
}