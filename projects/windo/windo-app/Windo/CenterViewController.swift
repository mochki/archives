//
//  CenterViewController.swift
//  Windo
//
//  Created by Joey on 3/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class CenterViewController: UIViewController {
    
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        
//        let addEventButton = UIBarButtonItem(image: UIImage(named: "AddButton"), style: UIBarButtonItemStyle.Plain, target: self, action: "toggleOpen")
        
        

    }
    
//    func addScreen(){
//        let login = LoginViewController()
//        login.delegate = self.delegate
//        self.navigationController?.pushViewController(login, animated: true)
//    }
}

extension CenterViewController: SidePanelViewControllerDelegate {
    func pageSelected(pageIndex: Int) {
        
//        var destinationViewController = CenterViewController()
//        
//        switch pageIndex{
//        case 0:
//            destinationViewController = HomeViewController()
//        case 1:
//            destinationViewController = ClimbsViewController()
//        case 2:
//            destinationViewController = FriendsViewController()
//        case 3:
//            destinationViewController = SettingsViewController()
//        case 4:
//            handleLogout()
//            return
//        default:
//            return
//        }
//        
//        delegate?.toggleLeftPanel?()
//        destinationViewController.delegate = self.delegate
//        
//        self.navigationController?.popToRootViewControllerAnimated(false)
//        self.navigationController?.pushViewController(destinationViewController, animated: false)
    }
    
    func handleLogout(){
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to logout?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in}
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Logout", style: .Destructive) { (action) in
            self.delegate?.toggleLeftPanel?()
        }
        
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}