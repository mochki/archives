//
//  ConnectingCirclesView.swift
//  Windo
//
//  Created by Joey on 4/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ConnectingCirclesView: UIView {
    
    //MARK: Properties
    let circleWidth: CGFloat = 10
    let circleViewWidth: CGFloat = 60
    
    var indicatorCircle = UIView()
    var circle1 = UIView()
    var circle2 = UIView()
    var circle3 = UIView()
    
    var connector1 = UIView()
    var connector2 = UIView()
    
    var firstConnectorVisible = false
    var secondConnectorVisible = false
    
    //MARK: View Configuration
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        
        let color = UIColor.grayColor()
        let alpha:CGFloat = 1.0
        let cornerRadius = circleWidth/2
        
        indicatorCircle.layer.cornerRadius = cornerRadius
        indicatorCircle.backgroundColor = UIColor.whiteColor()
        
        circle1.layer.cornerRadius = cornerRadius
        circle1.backgroundColor = color
        circle1.alpha = alpha
        
        circle2.layer.cornerRadius = cornerRadius
        circle2.backgroundColor = color
        circle2.alpha = alpha
        
        circle3.layer.cornerRadius = cornerRadius
        circle3.backgroundColor = color
        circle3.alpha = alpha
        
        connector1.backgroundColor = color
        connector1.layer.cornerRadius = cornerRadius
        connector1.transform = CGAffineTransformMakeScale(1.0, 0.00001)
        connector1.alpha = alpha
        
        connector2.backgroundColor = color
        connector2.layer.cornerRadius = cornerRadius
        connector2.transform = CGAffineTransformMakeScale(1.0, 0.00001)
        connector2.alpha = alpha
        
        addSubviews(connector1, connector2)
        addSubviews(circle1, circle2, circle3)
        addSubview(indicatorCircle)
    }
    
    func applyConstraints(){
        indicatorCircle.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.wh.of(circleWidth)
        )
        
        circle1.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.wh.of(circleWidth)
        )
        
        circle2.addConstraints(
            Constraint.cycy.of(self),
            Constraint.cxcx.of(self),
            Constraint.wh.of(circleWidth)
        )
        
        circle3.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self),
            Constraint.wh.of(circleWidth)
        )
        
        connector1.addConstraints(
            Constraint.cycy.of(self),
            Constraint.ll.of(self),
            Constraint.w.of((circleViewWidth + circleWidth)/2),
            Constraint.h.of(circleWidth)
        )
        
        connector2.addConstraints(
            Constraint.cycy.of(self),
            Constraint.rr.of(self),
            Constraint.w.of((circleViewWidth + circleWidth)/2),
            Constraint.h.of(circleWidth)
        )
    }
    
    func hideConnectors(){
        if firstConnectorVisible {
            UIView.animateWithDuration(0.15, animations: {
                self.connector1.transform = CGAffineTransformMakeScale(1.0, 0.000001)
            })
            firstConnectorVisible = false
            bounceLeft()
            bounceCenter()
        }
        
        if secondConnectorVisible {
            UIView.animateWithDuration(0.15, animations: {
                self.connector2.transform = CGAffineTransformMakeScale(1.0, 0.000001)
            })
            secondConnectorVisible = false
            bounceRight()
            bounceCenter()
        }
    }
    
    func showFirstConnector(){
        UIView.animateWithDuration(0.15, animations: {
            self.connector1.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        firstConnectorVisible = true
    }
    
    func showSecondConnector(){
        UIView.animateWithDuration(0.15, animations: {
            self.connector2.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
        secondConnectorVisible = true
    }
    
    func bounceLeft(){
        UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .CurveLinear, animations: {
                self.circle1.transform = CGAffineTransformMakeScale(0.75, 0.75)
            }, completion: {void in
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
                    self.circle1.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }
    
    func bounceCenter(){
        UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .CurveLinear, animations: {
            self.circle2.transform = CGAffineTransformMakeScale(0.75, 0.75)
            }, completion: {void in
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
                    self.circle2.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }
    
    func bounceRight(){
        UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .CurveLinear, animations: {
            self.circle3.transform = CGAffineTransformMakeScale(0.75, 0.75)
            }, completion: {void in
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
                    self.circle3.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }
    
//    func leftToCenter(){
//        circle1.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.ll.of(self),
//            Constraint.h.of(10),
//            Constraint.w.of(30)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    func centerToRight(){
//        circle2.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.LeftToCenterX.of(self, offset: -5),
//            Constraint.h.of(10),
//            Constraint.w.of(30)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    func rightToCenter(){
//        
//    }
//    
//    func centerToLeft(){
//        
//    }
//    
//    func reset(){
//        circle1.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.ll.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        circle2.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.cxcx.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        circle3.addConstraints(
//            Constraint.cycy.of(self),
//            Constraint.rr.of(self),
//            Constraint.wh.of(10)
//        )
//        
//        UIView.animateWithDuration(0.15) {
//            self.layoutIfNeeded()
//        }
//    }
}




