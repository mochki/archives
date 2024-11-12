//
//  UserProfile.swift
//  Windo
//
//  Created by Joey Nelson on 6/9/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class UserProfile: NSObject {
    var id: String //Firebase
    var fbID: String //Facebook
    var firstName: String
    var lastName: String
    var profilePictureURL: String
    var email: String
    
    override init() {
        id = ""
        fbID = ""
        firstName = ""
        lastName = ""
        profilePictureURL = ""
        email = ""
    }
    
    init(firebaseID: String, facebookID: String, first: String, last: String, url: String, email: String) {
        id = firebaseID
        fbID = facebookID
        firstName = first
        lastName = last
        profilePictureURL = url
        self.email = email
    }
    
    var fullName: String {
        if firstName == "" || lastName == "" {
            return ""
        } else {
            return "\(firstName) \(lastName)"
        }
    }
    
    func getInitials() -> String{
        let name = fullName
        if fullName.isEmpty {
            return ""
        }
        
        let firstInitial = "\(name[name.startIndex.advancedBy(0)])"
        
        guard let index = name.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(name[name.startIndex.advancedBy(name.startIndex.distanceTo(index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
    
    func profilePicture() -> UIImage? {
        guard let data = NSData(contentsOfURL: NSURL(string: profilePictureURL)!) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    //MARK: Coding
    
    required convenience init?(coder decoder: NSCoder) {
        guard   let id = decoder.decodeObjectForKey("id") as? String,
                let fbID = decoder.decodeObjectForKey("fbID") as? String,
                let first = decoder.decodeObjectForKey("firstName") as? String,
                let last = decoder.decodeObjectForKey("lastName") as? String,
                let url = decoder.decodeObjectForKey("url") as? String,
                let email = decoder.decodeObjectForKey("email") as? String
            else { return nil }
        
        self.init(
            firebaseID: id,
            facebookID: fbID,
            first: first,
            last: last,
            url: url,
            email: email
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.fbID, forKey: "fbID")
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.profilePictureURL, forKey: "url")
        coder.encodeObject(self.email, forKey: "email")
    }
}