//
//  TCPickerDataTool.swift
//  TimeCapsule
//
//  Created by 章凯华 on 12/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import Foundation

enum TCMonthClickStatus {
    case previous
    case next
}

enum TCCustomViewPosition {
    case left
    case middle
    case right
}

enum TCClockPickerState:Int {
    case minutes = 0
    case hour
}

enum TCClockHourStatus:Int {
    case AM = 0
    case PM
}
