//
//  Event.swift
//  Windo
//
//  Created by Joey on 5/27/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import CoreLocation

class Event {

    var ID: String!
    var name: String!
    var location: CLLocation!
    var members: [User]!
    var eventCreator: User!
    var dateCreated: NSDate!
    var eventWindo: Windo!
    var memberWindos: [Windo]!
    var messages: [Message]!
    var possibleTimes: [NSDate]!
    
    // flags
    var isPast: Bool!
    var timesFound: Bool!
    
    // MARK: Public
    init() {
        
    }
    
    init(id: String, name: String, location: CLLocation, members: [User], eventCreator: User, dateCreated: NSDate, eventWindo: Windo, memberSubmissions: [Windo], messages: [Message], possibleTimes: [NSDate]) {
        self.ID = id
        self.name = name
        self.location = location
        self.members = members
        self.eventCreator = eventCreator
        self.dateCreated = dateCreated
        self.eventWindo = eventWindo
        self.memberWindos = memberSubmissions
        self.messages = messages
        self.possibleTimes = possibleTimes
    }
    
    // MARK: Private
    
}