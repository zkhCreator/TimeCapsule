//
//  TCEventModel.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

enum TCEventType {
    case finished
    case planed
}

class TCEventModel: NSObject {
    var time:Date
    var notiEnable:Bool
    var summary:String
    var status:TCEventType
    
    override init() {
        time = Date()
        notiEnable = true
        summary = ""
        status = .planed
    }
}
