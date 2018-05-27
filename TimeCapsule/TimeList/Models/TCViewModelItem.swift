//
//  TCViewModelItem.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/27.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

enum TCTimeListCellType {
    case create,   // 第一个，用来作为创建的
    defaultType   // 默认内容填充
}

class TCViewModelItem: NSObject {
    let type:TCTimeListCellType
    var height:CGFloat = 0
    
    init(with type:TCTimeListCellType = .create, height:CGFloat = createItemHeight) {
        self.type = type
        super.init()
    }
    
    
}
