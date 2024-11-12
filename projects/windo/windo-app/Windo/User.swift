//
//  User.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation

class User {

    var ID: String!
    var email: String!
    var facebookID: String!
    var name: String!
    var friendIDs: [String]!
    var eventIDs: [String]!
    
    // MARK: Public
    init() {
        
    }
    
    init(id: String, email: String, facebookID: String, name: String, friendIDs: [String], eventIDs: [String]) {
        self.ID = id
        self.email = email
        self.facebookID = facebookID
        self.name = name
        self.friendIDs = friendIDs
        self.eventIDs = eventIDs
    }
    
    
    // MARK: Private
    
    
}

enum ResponseStatus : String {
    case NeedsResponse = "needsResponse", HasResponded = "hasResponded"
    static let allValues = [NeedsResponse, HasResponded]
}

/*
 "eventIDs": {
    "upcoming": {
        "eventID": { ResponseStatus }
        "eventID1": { "hasResponded" },
        "eventID2": { "responseNeeded" },
    "past": {
 
 */