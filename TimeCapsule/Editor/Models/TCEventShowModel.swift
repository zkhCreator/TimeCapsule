//
//  TCEventShowModel.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//  事件层直接和界面通信

import UIKit

class TCEventShowModel: NSObject {
    
    let manager:TCTimeManager
    var yearString:String {
        get {
            return manager.year.toString()
        }
    }
    
    var monthString:String {
        get {
            var month:String = ""
            switch manager.month {
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
    }
    
    var dayString:String {
        get {
            return manager.day.toString()
        }
    }
    
    var weekString:String {
        get {
            var week:String
            switch manager.week {
            case .Monday:
                week = "Mon"
            case .Tuesday:
                week = "Tue"
            case .Wednesday:
                week = "Wed"
            case .Thursday:
                week = "Thu"
            case .Friday:
                week = "Fri"
            case .Saturday:
                week = "Sat"
            case .Sunday:
                week = "Sun"
            }
            return week
        }
    }
    
    var timeString:String {
        get {
            let hourString = manager.hour.toString().count > 1 ? manager.hour.toString() : "0" + manager.hour.toString()
            let minuteString = manager.minute.toString().count > 1 ? manager.minute.toString() : "0" + manager.minute.toString()
            
            return hourString + ":" + minuteString
        }
    }
    var summaryString:String
    
    
    init(with model:TCEventModel) {
        manager = TCTimeManager.init(with: model.time)
        summaryString = model.summary
    }
}
