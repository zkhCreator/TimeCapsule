//
//  TCTimeListViewModels.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/27.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListViewModels: NSObject {
    var viewModelArray:[TCViewModelItem] = []
    
    override init() {
        super.init()
        let creatItem = TCViewModelItem.init(with: .create)
        viewModelArray.append(creatItem)
    }
    
    func count() -> Int {
        return viewModelArray.count
    }
    
    func removeAll() {
        viewModelArray.removeAll()
        let createItem = TCViewModelItem.init(with: .create)
        viewModelArray.append(createItem)
    }
    
    func updateAllData(with array:[TCViewModelItem]) {
        self.removeAll()
        viewModelArray.append(contentsOf: array)
    }
    
    func safeObject(with indexPath:NSIndexPath) -> TCViewModelItem? {
        let index = indexPath.row
        return viewModelArray[safe: index]
    }
}
