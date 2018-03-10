//
//  TCEventContentViewModel.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

enum TCEventContentViewModelType {
    case text
    case image
    case taskList
}

protocol TCEventContentProtocol {
    func type() -> TCEventContentViewModelType
    func contentString() -> NSAttributedString
}

class TCEventContentViewModel: NSObject {
    var type:Array<TCEventContentProtocol> = []
}
