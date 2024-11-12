//
//  SideMenuViewController.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol SidePanelViewControllerDelegate {
    func pageSelected(pageIndex: Int)
}

class SidePanelViewController: UIViewController {
    
    var delegate: SidePanelViewControllerDelegate?
    var sideMenuView = SideMenuView()
    let userProfile = UserManager.userProfile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.superLightTeal()
        sideMenuView = SideMenuView(frame: self.view.frame)
        view.addSubview(sideMenuView)
        sideMenuView.profileImage.setupView(userProfile, width: 90)
        sideMenuView.nameLabel.text = userProfile.fullName
        addTargets()
    }
    
    func handleNavigate(sender: UIButton){
        delegate?.pageSelected(sender.tag)
    }
    
    func addTargets(){
        sideMenuView.help.addTarget(self, action: #selector(SidePanelViewController.openTutorial), forControlEvents: .TouchUpInside)
        sideMenuView.signOut.addTarget(self, action: #selector(SidePanelViewController.signOut), forControlEvents: .TouchUpInside)
    }
    
    func openTutorial(){
        let tutorialVC = TutorialViewController()
        presentViewController(tutorialVC, animated: true, completion: nil)
    }
    
    func signOut() {
//        UserManager.sharedManager.signOut()
    }
}

