//
//  DataProvider.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseDatabase
import FirebaseAuth

class DataProvider {
    
    static let sharedProvider = DataProvider()
    let dbRef = FIRDatabase.database().reference()

    // PATHS
    let userPath = "users"
    let IDtoIDPath = "IDtoID" // matching provisioner (Google, Facebook) ID to Firebase ID
    let eventPath = "events"
    let windoPath = "windos"
    
    
    // MARK: Events
    
    func createEvent(invitees: [UserProfile], selectedTimes: [NSDate]) {
        let id = String.randomAlphaNumericString(20)
        let creator = UserManager.userProfile.fbID
        let originTimeZone = NSTimeZone.localTimeZone().abbreviation
        
        var members = [String]()
        for user in invitees {
            members.append(user.fbID)
        }
        
        var times = [String]()
        for time in selectedTimes {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd-hh"
            let timeString = formatter.stringFromDate(time)
            times.append(timeString)
        }
        
        let newEventPath = "\(eventPath)/\(id)/"
        
        dbRef.child("\(newEventPath)/id").setValue(id)
        dbRef.child("\(newEventPath)/creator").setValue(creator)
        dbRef.child("\(newEventPath)/originTimeZone").setValue(originTimeZone)
        dbRef.child("\(newEventPath)/members").setValue(members)
        dbRef.child("\(newEventPath)/times").setValue(times)
        
//        for member in members {
            //TODO: Add eventID to all invited users' events
//        }
    }
    
    
    // MARK: User
    /// Retrieves current user's profile from facebook and stores it in NSUserDefaults
    func fetchUserProfileFromFacebook() {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), friends"])
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            request.startWithCompletionHandler({ (connection, result, error) in
                
                if let e = error {
                    print(e)
                    return
                }
                
                let info = result as! NSDictionary
                
                if let fbID = info.valueForKey("id") as? String {
                    UserManager.userProfile.fbID = fbID
                }
                
                if let firstName = info.valueForKey("first_name") as? String {
                    UserManager.userProfile.firstName = firstName
                }
                
                if let lastName = info.valueForKey("last_name") as? String {
                    UserManager.userProfile.lastName = lastName
                }
                
                if let email = info.valueForKey("email") as? String {
                    UserManager.userProfile.email = email
                }
                
                if let friendsData = info.valueForKey("friends") as? NSDictionary {
                    DataProvider.sharedProvider.fetchUserFriends(friendsData)
                }
                
                if let imageURL = info.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String {
                    UserManager.userProfile.profilePictureURL = imageURL
                }
                
                let userData = NSKeyedArchiver.archivedDataWithRootObject(UserManager.userProfile)
                NSUserDefaults.standardUserDefaults().setObject(userData, forKey: kUserProfile)
            })
        }
    }
    
    func fetchUserFriends() {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "friends"])
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            request.startWithCompletionHandler({ (connection, result, error) in
                if let e = error {
                    print(e)
                    return
                }
                let info = result as! NSDictionary
                if let friendsData = info.valueForKey("friends") as? NSDictionary {
                    DataProvider.sharedProvider.fetchUserFriends(friendsData)
                }
            })
        }
    }
    
    func fetchUserFriends(data: NSDictionary){
        UserManager.friends.removeAll()
        if let friendsList = data.objectForKey("data") as? NSArray {
            for friend in friendsList {
                if let id = friend.valueForKey("id") as? String {
                    self.fetchFriendProfile(id)
                }
            }
        }
    }
    
    func fetchFriendProfile(id: String){
        let request = FBSDKGraphRequest(graphPath: id, parameters: ["fields": kFriendFBFields])
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            request.startWithCompletionHandler({ (connection, result, error) in
                let info = result as! NSDictionary
                
                let friend = UserProfile()
                guard
                    let firstName = info.valueForKey("first_name") as? String,
                    let lastName = info.valueForKey("last_name") as? String,
                    let imageURL = info.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String
                    else { return }
                friend.firstName = firstName
                friend.lastName = lastName
                friend.profilePictureURL = imageURL
                friend.fbID = id
                UserManager.friends.append(friend)
            })
        }
    }
    
    /// Uploads User to Firebase
    func uploadUser() {        
        let user = UserManager.userProfile
        
        let path = "\(userPath)/\(user.fbID)/"
        
        dbRef.child("\(path)name").setValue(user.fullName)
        dbRef.child("\(path)email").setValue(user.email)
        dbRef.child("\(path)imageURL").setValue(user.profilePictureURL)
        
        DataProvider.sharedProvider.uploadUserFriends()
    }

    func ifNewUser(doThis: ()->()) {
        let user = UserManager.userProfile
        dbRef.child(userPath).child(user.fbID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if !snapshot.exists() {
                doThis()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func uploadUserFriends() {
        if UserManager.friends.isEmpty { return }
        
        let user = UserManager.userProfile
        var friendsArray = [String]()
        for friend in UserManager.friends {
            friendsArray.append(friend.fbID)
        }
        
        dbRef.child("\(userPath)/\(user.fbID)/friends").setValue(friendsArray)
    }
}