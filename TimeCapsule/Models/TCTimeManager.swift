//
//  TCTimeManager.swift
//  TimeCapsule
//
//  Created by 章凯华 on 09/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeManager: NSObject {
    var date:Date
    
    var comp = DateComponents()
    
    var year:Int {
        set {
            comp.year = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .year, date: date)
        }
    }
    
    var month:Int {
        set {
            comp.month = newValue
            guard let newDate = Calendar.current.date(from: comp) else {
                return
            }
            date = newDate
        }
        get {
            return TCTimeAdapter.convert(to: .month, date: date)
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
    
    init(with date:Date = Date()) {
        self.date = date
        self.comp = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second, timezone], from: date)
        super.init()
    }
    
    override var description: String {
        return "year:\(year) month:\(month) day:\(day) hour:\(hour) minute:\(minute) second:\(day)"
    }
}
