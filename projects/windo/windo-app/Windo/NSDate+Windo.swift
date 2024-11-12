//
//  NSDate+Windo.swift
//  Windo
//
//  Created by Joey on 3/24/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    
    
    func getFormattedDate(endDate: NSDate) -> String{
        var date = ""
        if(self.fullDate() == endDate.fullDate()){
            date = "\(self.fullDate())"
        }
        else if(self.year() != endDate.year()){
            date = "\(self.monthAbbrev()) \(self.day()), \(self.year()) - \(endDate.monthAbbrev()) \(endDate.day()), \(endDate.year())"
        }
        else if self.month() == endDate.month(){
            date = "\(self.monthName()) \(self.day())-\(endDate.day()), \(self.year())"
        }
        else{
            date = "\(self.monthAbbrev()) \(self.day())-\(endDate.monthAbbrev()) \(endDate.day()), \(self.year())"
        }
        return date
    }
    
    func hour() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Hour], fromDate: self)
        return day.hour
    }
    
    func pmHour() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Hour], fromDate: self)
        if day.hour > 12 {
            return day.hour - 12
        }
        else {
            return day.hour
        }
    }
    
    func day() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Day], fromDate: self)
        return day.day
    }
    
    func month() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.components([.Month], fromDate: self)
        return month.month
    }
    
    func year() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let year = calendar.components([.Year], fromDate: self)
        return year.year
    }
    
    func fullDate() -> String{
        return "\(self.monthName()) \(self.day()), \(self.year())"
    }
    
    func monthAbbrev() -> String{
        switch self.month(){
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func monthAbbrevCap() -> String{
        switch self.month(){
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAY"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func monthName() -> String{
        switch self.month(){
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    static func monthName(month: Int) -> String{
        switch month{
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func dayOfWeek() -> String{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Weekday], fromDate: self)
        switch day.weekday{
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Invalid weekday ya ding dong"
        }
    }
    
    func abbrevDayOfWeek() -> String{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Weekday], fromDate: self)
        switch day.weekday{
        case 1:
            return "SUN"
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        default:
            return "Invalid weekday ya ding dong"
        }
    }
    
    func startOfMonth() -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components([.Year, .Month], fromDate: self) else { return nil }
        comp.to12pm()
        return cal.dateFromComponents(comp)!
    }
    
    func endOfMonth() -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = NSDateComponents() else { return nil }
        comp.month = 1
        comp.day -= 1
        comp.to12pm()
        return cal.dateByAddingComponents(comp, toDate: self.startOfMonth()!, options: [])!
    }
    
    func firstWeekday() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let firstDay = self.startOfMonth()
        let firstComponents = calendar.components([.Weekday], fromDate: firstDay!)
        return firstComponents.weekday
    }
    
    func daysInTheMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: self)
        let startOfMonth = calendar.dateFromComponents(components)!
        let comps2 = NSDateComponents()
        comps2.month = 1
        comps2.day = -1
        let lastDay = calendar.dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
        return lastDay.day()
    }
}

internal extension NSDateComponents {
    func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}




