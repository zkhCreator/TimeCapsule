//
//  TCTimeManager.swift
//  TimeCapsule
//
//  Created by 章凯华 on 09/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

let monthDayArray:[Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

struct TCTimeManager {
    var date:Date
    
    var comp = DateComponents()
    
    var year:Int {
        set {
            comp.year = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
        }
        get {
            return TCTimeAdapter.convert(to: .year, date: date)
        }
    }
    
    var month:TCMonth {
        set {
            comp.month = newValue.rawValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convertMonth(with: date)
        }
    }
    
    var day:Int {
        set {
            comp.day = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .day, date: date)
        }
    }
    
    var hour:Int {
        set {
            comp.hour = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .hour, date: date)
        }
    }
    
    var minute:Int  {
        set {
            comp.minute = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .minute, date: date)
        }
    }
    
    var second:Int  {
        set {
            comp.second = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .second, date: date)
        }
    }
    
    var week:TCWeekday {
        set {
            comp.weekday = newValue.rawValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convertWeekday(with: date)
        }
    }
    
    var currentMonthDay:Int {
        get {
            switch month {
            case .February:
                return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? 29 : 28
            default:
                return monthDayArray[month.rawValue - 1]
            }
        }
    }
    
    var firstDayWeekDay:TCWeekday {
        get {
            let firstDay = self.day % 7
            var currentWeekValue = self.week.rawValue - (firstDay - 1)
            if currentWeekValue < 1 {
                currentWeekValue = currentWeekValue + 7
            }
            return TCWeekday(rawValue: currentWeekValue)!
        }
    }
    
    init(with date:Date = Date()) {
        self.date = date
        self.comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
    }
}
