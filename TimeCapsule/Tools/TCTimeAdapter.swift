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
}
