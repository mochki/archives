//
//  ViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //MARK: Properties
    
    var loginView = LoginView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = loginView
        loginView.loginButton.delegate = self
        
        loginView.loginButton.readPermissions = fbPermissions
        
        loginView.facebookButton.addTarget(self, action: #selector(LoginViewController.facebookLogin), forControlEvents: .TouchUpInside)
    }
    
    func facebookLogin() {        
        loginView.loginButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        UserManager.sharedManager.fbLogin(didCompleteWithResult: result, error: error)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        UserManager.sharedManager.fbLogout()
    }
}
