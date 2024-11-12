//
//  UserManager.swift
//  Windo
//
//  Created by Joey on 6/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class UserManager {
    
    static let sharedManager = UserManager()
    static var userProfile = UserProfile()
    static var friends = [UserProfile]()
    
    func userIsLoggedIn() -> Bool {
        if let _ = FIRAuth.auth()?.currentUser {
            return true
        } else {
            return false
        }
    }
    
    func login(loadHomeScreen: Bool) {
        // Firebase Login
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            if loadHomeScreen {
                //fetch user's events and open home screen on completion
                let rootVC = ContainerViewController()
                let window = UIApplication.sharedApplication().delegate!.window!
                window!.rootViewController = rootVC
                window!.makeKeyAndVisible()
                
                DataProvider.sharedProvider.ifNewUser({DataProvider.sharedProvider.uploadUser()})
            }
        }
    }
    
    func signOut() {
        try! FIRAuth.auth()!.signOut()

        if let _ = FIRAuth.auth()?.currentUser {
            return
        } else {
            let rootVC = LoginViewController()
            print("sign out hit")
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kUserProfile)
            NSUserDefaults.standardUserDefaults().removeObjectForKey("friends")
            
            let window = UIApplication.sharedApplication().delegate!.window!
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }
    }
    
    func fetchUserProfile() {
        if fetchUserProfileFromDefaults() {
            DataProvider.sharedProvider.fetchUserFriends()
            return
        } else {
            DataProvider.sharedProvider.fetchUserProfileFromFacebook()
        }
    }
    
    func fetchUserProfileFromDefaults() -> Bool {
        guard let data = NSUserDefaults.standardUserDefaults().objectForKey(kUserProfile) as? NSData else { return false }
        guard let userProfile = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserProfile else { return false }
        UserManager.userProfile = userProfile
        return true
    }
    
    // MARK: Facebook
    func fbLogin(didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {        
        if ((error) != nil) {
            return
        } else if result.isCancelled {
            return
        } else {
            DataProvider.sharedProvider.fetchUserProfileFromFacebook()
            self.login(true)
        }
    }
    
    func fbLogout() {
        try! FIRAuth.auth()!.signOut()
        
        let rootVC = LoginViewController()
        let window = UIApplication.sharedApplication().delegate!.window!
        window!.rootViewController = rootVC
        window!.makeKeyAndVisible()
    }
}