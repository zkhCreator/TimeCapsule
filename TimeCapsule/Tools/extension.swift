//
//  extension.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import Foundation

extension Int {
    static func toInt(from string:String) -> Int? {
        return Int(string)
    }
    
    func toString() -> String {
        return "\(self)"
    }
}


let monthDayArray:[Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

extension Date {
    static func getBegin(year:Int, of month:Int, timeZone:TimeZone) -> Date {
        if year < 0 || month < 1 || month > 12 {
            assert(false, "生成月初失败")
            return Date()
        }
        
        var comp = DateComponents.init()
        comp.year = year
        comp.month = month
        comp.day = 1
        comp.timeZone = timeZone
        
        return Calendar.current.date(from: comp)!
    }
    
    func nextMonth() -> Date {
        var comp = self.dateComponet()
        comp.day = 1
        if comp.month == 12 {
            comp.year = comp.year! + 1
            comp.month = 1
        } else {
            comp.month = comp.month! + 1
        }
        return Calendar.current.date(from: comp)!
    }
    
    func previousMonth() -> Date {
        var comp = self.dateComponet()
        comp.day = 1
        if comp.month == 1 {
            comp.year = comp.year! - 1
            comp.month = 12
        } else {
            comp.month = comp.month! - 1
        }
        return Calendar.current.date(from: comp)!
    }
    
    func monthDay() -> Int {
        var comp = Calendar.current.dateComponents([.year, .month], from: self)
        let month = comp.month!
        let year = comp.year!

        if month == 2 {
            return (comp.isLeapMonth!) ? 29 : 28
        } else {
            return monthDayArray[month - 1]
        }
    }
    
    static func customDate(year:Int, month:Int, day:Int, hour:Int, minute:Int, timeZone:TimeZone) -> Date {
        var comp = DateComponents.init()
        comp.year = year
        comp.month = month
        comp.day = day
        comp.hour = hour
        comp.minute = minute
        comp.timeZone = timeZone
        
        return Calendar.current.date(from: comp)!
    }
    
    func dateComponet() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .timeZone], from: self)
    }
}

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
