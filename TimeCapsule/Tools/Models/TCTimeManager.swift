//
//  TCTimeManager.swift
//  TimeCapsule
//
//  Created by 章凯华 on 09/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit


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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
            comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
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
    
    var lastMonthDay:Int {
        // 获得上一个月份的月份
        var lastMonthValue = month.rawValue - 1
        // 防止年份越界
        if lastMonthValue <= 0 {
            lastMonthValue = lastMonthValue + 1
        }
        // 如果上一个月份为 2 单独判断
        if lastMonthValue == 2 {
            return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? 29 : 28
        }
        
        return monthDayArray[month.rawValue - 1]
    }
    
    var firstDayWeekDay:TCWeekday {
        get {
            let firstDayDate = Date.getBegin(year: self.year, of: self.month.rawValue, timeZone: self.comp.timeZone!)
            let tempComp = Calendar.current.dateComponents([.weekday, .year, .day, .month], from: firstDayDate)

            return TCWeekday(rawValue: tempComp.weekday!)!
        }
    }
    
    init(with date:Date = Date()) {
        self.date = date
        self.comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, .timeZone], from: date)
    }
}
