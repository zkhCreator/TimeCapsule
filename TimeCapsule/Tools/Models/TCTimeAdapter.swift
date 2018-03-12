//
//  TCTimeAdapter.swift
//  TimeCapsule
//
//  Created by 章凯华 on 09/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

enum TCWeekday:Int {
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    case Sunday = 1
}

enum TCMonth:Int {
    case January = 1
    case February = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
}

enum TCDateOption {
    case year
    case month
    case day
    case hour
    case minute
    case second
}

class TCTimeAdapter: NSObject {
    static func convertWeekday(with date:Date) -> TCWeekday {
        let dayNum = convert(component:.weekday, date: date)
        let weekday = TCWeekday.init(rawValue: dayNum)
        return weekday!
    }
    
    static func convertMonth(with date:Date) -> TCMonth {
        let month = convert(component: .month, date: date)
        let monthName = TCMonth.init(rawValue: month)
        return monthName!
    }
    
    static func convert(to type:TCDateOption, date:Date) -> Int {
        var num:Int = 0
        switch type {
        case .year:
            num = convert(component: .year, date: date)
        case .month:
            num = convert(component: .month, date: date)
        case .day:
            num = convert(component: .day, date: date)
        case .hour:
            num = convert(component: .hour, date: date)
        case .minute:
            num = convert(component: .minute, date: date)
        case .second:
            num = convert(component: .second, date: date)
        }
        return num
    }
    
    static func convert(component:Calendar.Component, date:Date) -> Int {
        let time = Calendar.current.component(component, from: date)
        return time
    }
    
    static func showMonthOmissionName(monthEnum:TCMonth) -> String {
        var month:String = ""
        switch monthEnum {
        case .January:
            month = "Jan."
        case .February:
            month = "Feb."
        case .March:
            month = "Mar."
        case .April:
            month = "Apr."
        case .May:
            month = "May."
        case .June:
            month = "Jun."
        case .July:
            month = "Jul."
        case .August:
            month = "Aug."
        case .September:
            month = "Sep."
        case .October:
            month = "Oct."
        case .November:
            month = "Nov."
        case .December:
            month = "Dec."
        }
        return month
    }
    
    static func showMonthFullName(monthEnum:TCMonth) -> String {
        var month:String = ""
        switch monthEnum {
        case .January:
            month = "January"
        case .February:
            month = "February"
        case .March:
            month = "March"
        case .April:
            month = "April"
        case .May:
            month = "May"
        case .June:
            month = "June"
        case .July:
            month = "July"
        case .August:
            month = "August"
        case .September:
            month = "September"
        case .October:
            month = "October"
        case .November:
            month = "November"
        case .December:
            month = "December"
        }
        return month
    }
    
    static func showWeekFullName() -> [String] {
        return ["Monday", "Tuesday", "WednesDay", "Thursday", "Friday", "Saturday", "Sunday"]
    }
    
    static func showWeekOmissionName() -> [String] {
        return ["Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.", "Sun."]
    }
    
    static func showSunFirstWeekFullName() -> [String] {
        return ["Sunday", "Monday", "Tuesday", "WednesDay", "Thursday", "Friday", "Saturday"]
    }
    
    static func showSunFirstWeekOmissionName() -> [String] {
        return ["Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat."]
    }
}
