//
//  UIString+.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension String {
    func getInitials() -> String{
        let firstInitial = "\(self[self.startIndex.advancedBy(0)])"
        
        guard let index = self.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(self[self.startIndex.advancedBy(self.startIndex.distanceTo(index) + 1)])"
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
    
    static func randomAlphaNumericString(length: Int) -> String {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    static func randomNumericString(length: Int) -> String {
        
        let allowedChars = "0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func isAlpha() -> Bool {
        for uni in self.unicodeScalars {
            if NSCharacterSet.decimalDigitCharacterSet().longCharacterIsMember(uni.value) {
                return true
            }
        }
        return false
    }
}