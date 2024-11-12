//
//  UIColor+Windo.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

extension UIColor{
    class func fromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func teal() -> UIColor{
        let color = UIColor.fromHex(0x0DB2B1, alpha: 1.0)
        return color
    }
    
    class func lightTeal() -> UIColor{
        let color = UIColor.fromHex(0x2ECECD, alpha: 1.0)
        return color
    }
    
    class func darkTeal() -> UIColor{
        let color = UIColor.fromHex(0x088F8E, alpha: 1.0)
        return color
    }
    
    class func superLightTeal() -> UIColor{
        let color = UIColor.fromHex(0xC3F0F0, alpha: 1.0)
        return color
    }
    
    class func purple() -> UIColor{
        let color = UIColor.fromHex(0x9159F7, alpha: 1.0)
        return color
    }
    
    class func lightPurple() -> UIColor{
        let color = UIColor.fromHex(0xA676FF, alpha: 1.0)
        return color
    }
    
    class func darkPurple() -> UIColor{
        let color = UIColor.fromHex(0x590196, alpha: 1.0)
        return color
    }
    
    class func darkPurple(alpha: Double) -> UIColor{
        let color = UIColor.fromHex(0x590196, alpha: alpha)
        return color
    }
    
    class func blue() -> UIColor{
        let color = UIColor.fromHex(0x4760EB, alpha: 1.0)
        return color
    }
    
    class func lightBlue() -> UIColor{
        let color = UIColor.fromHex(0x4C73FF, alpha: 1.0)
        return color
    }
    
    class func darkBlue() -> UIColor{
        let color = UIColor.fromHex(0x3340BA, alpha: 1.0)
        return color
    }
    
    class func mikeBlue() -> UIColor{
        let color = UIColor.fromHex(0x000667, alpha: 1.0)
        return color
    }
    
    class func mikeBlue(alpha: Double) -> UIColor{
        let color = UIColor.fromHex(0x000667, alpha: alpha)
        return color
    }
    
    
    
    
    class func stringToHex(s: NSString)->Int{
        let numbers = [
            "a": 10, "A": 10,
            "b": 11, "B": 11,
            "c": 12, "C": 12,
            "d": 13, "D": 13,
            "e": 14, "E": 14,
            "f": 15, "F": 15,
            "0": 0
        ]
        
        var number: Int = Int()
        if(s.intValue > 0){
            number = s.integerValue
        }
        else{
            number = numbers[s as String]!
        }
        return number
    }
    
    func rgb() -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = CGFloat(fRed * 255.0)
            let iGreen = CGFloat(fGreen * 255.0)
            let iBlue = CGFloat(fBlue * 255.0)
            let iAlpha = CGFloat(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    class func ColorFromRedGreenBlue(red: NSString, green: NSString, blue: NSString)->UIColor{
        
        var first: NSString = red.substringToIndex(1)
        var second = red.substringFromIndex(1)
        var varOne = stringToHex(first)
        var varTwo = stringToHex(second)
        let redValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        first = green.substringToIndex(1)
        second = green.substringFromIndex(1)
        varOne = stringToHex(first)
        varTwo = stringToHex(second)
        let greenValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        first = blue.substringToIndex(1)
        second = blue.substringFromIndex(1)
        varOne = stringToHex(first)
        varTwo = stringToHex(second)
        let blueValue: CGFloat = (CGFloat(varOne) * 16.0 + CGFloat(varTwo)) / 255.0
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    class func languageCellColor(hex: String)->UIColor{
        var color = NSAttributedString(string: hex)
        var range = NSMakeRange(1, color.length - 1)
        color = color.attributedSubstringFromRange(range)
        range = NSMakeRange(0, 2)
        let red = color.attributedSubstringFromRange(range)
        range = NSMakeRange(2, 2)
        let green = color.attributedSubstringFromRange(range)
        range = NSMakeRange(4, 2)
        let blue = color.attributedSubstringFromRange(range)
        return ColorFromRedGreenBlue(red.string, green: green.string, blue: blue.string)
    }
}