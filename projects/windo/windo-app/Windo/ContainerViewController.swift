//
//  ContainerViewController.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var tapToClose: UITapGestureRecognizer!
    
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var leftViewController: SidePanelViewController?
    
    var centerPanelCenter: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        centerViewController = HomeViewController()
        centerViewController.delegate = self
        centerPanelCenter = view.center.x
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
        
        centerNavigationController.navigationBar.barTintColor = UIColor.lightTeal()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        tapToClose = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.collapseSidePanel))
        
        addLeftPanelViewController()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
//        if notAlreadyExpanded {
//            addLeftPanelViewController()
//        }
        
        if currentState == .BothCollapsed{
            if let homeVC = centerNavigationController.viewControllers[0] as? HomeViewController {
                homeVC.homeView.eventTableView.scrollEnabled = false
            }
            
            centerNavigationController.view.addGestureRecognizer(tapToClose)
        }
        else {
            if let homeVC = centerNavigationController.viewControllers[0] as? HomeViewController {
                homeVC.homeView.eventTableView.scrollEnabled = true
            }
            
            centerNavigationController.view.removeGestureRecognizer(tapToClose)
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanel() {
        toggleLeftPanel()
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = SidePanelViewController()
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(shouldExpand shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            centerNavigationController.view.addGestureRecognizer(tapToClose)
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
            
            if let homeVC = centerNavigationController.viewControllers[0] as? HomeViewController {
                homeVC.homeView.eventTableView.scrollEnabled = false
            }
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                self.centerNavigationController.view.removeGestureRecognizer(self.tapToClose)
//                self.leftViewController!.view.removeFromSuperview()
//                self.leftViewController = nil;
            }
            
            if let homeVC = centerNavigationController.viewControllers[0] as? HomeViewController {
                homeVC.homeView.eventTableView.scrollEnabled = true
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        
    }
    
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        if(centerNavigationController.viewControllers.count > 1) { return }
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed) {
                addLeftPanelViewController()
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            if(recognizer.view!.center.x + recognizer.translationInView(view).x > centerPanelCenter){
                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                recognizer.setTranslation(CGPointZero, inView: view)
            }
            
            
        case .Ended:
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}
