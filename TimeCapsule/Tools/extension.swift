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
