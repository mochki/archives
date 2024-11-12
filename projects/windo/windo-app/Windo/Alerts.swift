//
//  Alerts.swift
//  Windo
//
//  Created by Joey on 7/8/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

protocol Alerts {
    func showAlert(alertView: WindoAlertView)
    func hideAlert(alertView: WindoAlertView)
}

extension Alerts where Self: UIViewController {
    
    func showAlert(alertView: WindoAlertView) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { 
                alertView.center = self.view.center
            }, completion: nil)
    }
    
    func hideAlert(alertView: WindoAlertView) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
            alertView.transform = CGAffineTransformIdentity
            }, completion: { finished in
                alertView.removeFromSuperview()
        })
    }
}