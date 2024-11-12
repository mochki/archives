//
//  TutorialViewController.swift
//  Windo
//
//  Created by Joey on 4/4/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    
    var tutorialView = TutorialView()
    
    var red = CGFloat()
    var blue = CGFloat()
    var green = CGFloat()
    
    var colors = [UIColor]()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = tutorialView
        tutorialView.mainScrollView.delegate = self
        addTargets()
        
        colors = [UIColor.teal(), UIColor.blue(), UIColor.purple()]
        tutorialView.mainView.backgroundColor = colors[0]
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addTargets(){
        tutorialView.xButton.addTarget(self, action: #selector(TutorialViewController.dismissTutorial), forControlEvents: .TouchUpInside)
    }
    
    func dismissTutorial(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > (screenWidth * 2) {
            return
        }
        
        let percent = scrollView.contentOffset.x/(screenWidth * 2)
        
        if percent <= 0.5 {
            let tempPercent = percent * 2
            let rgb = transitionColorToColor(colors[0], toColor: colors[1], percent: tempPercent)
            
            red = rgb.red
            green = rgb.green
            blue = rgb.blue
        }
        else {
            let tempPercent = (percent - 0.5) * 2
            let rgb = transitionColorToColor(colors[1], toColor: colors[2], percent: tempPercent)
            
            red = rgb.red
            green = rgb.green
            blue = rgb.blue
        }
        
        let background = UIColor(red:red/256, green:green/256, blue:blue/256, alpha: 1.0)
        tutorialView.mainView.backgroundColor = background
        
        
        let circlesWidth = tutorialView.circles.frame.width - tutorialView.circles.indicatorCircle.frame.width
        tutorialView.circles.indicatorCircle.transform = CGAffineTransformMakeTranslation(percent * circlesWidth, 0)
        
        if percent < 0.5 {
            tutorialView.circles.showFirstConnector()
        }
        else if percent > 0.5 {
            tutorialView.circles.showSecondConnector()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        tutorialView.circles.hideConnectors()
    }
    
    func transitionColorToColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat){
        let fromRGB = fromColor.rgb()!
        let toRGB = toColor.rgb()!
        
        red = fromRGB.red + (percent * (toRGB.red - fromRGB.red))
        green = fromRGB.green + (percent * (toRGB.green - fromRGB.green))
        blue = fromRGB.blue + (percent * (toRGB.blue - fromRGB.blue))
        
        return (red: red, green: green, blue: blue)
    }
}
