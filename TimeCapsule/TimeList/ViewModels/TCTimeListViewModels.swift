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
    let creatItem:TCViewModelItem = TCViewModelItem.init(with: .create)
    
    override init() {
        super.init()
        viewModelArray.append(creatItem)
        for _ in 0..<10 {
            let item = TCViewModelItem.init()
            viewModelArray.append(item)
        }
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
        viewModelArray.append(creatItem)
        viewModelArray.append(contentsOf: array)
    }
    
    func safeObject(with indexPath:IndexPath) -> TCViewModelItem? {
        let index = indexPath.row
        return viewModelArray[safe: index]
    }
}
