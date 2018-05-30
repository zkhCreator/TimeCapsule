//
//  TCTimeListCreateNewItemView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/22.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

enum TCTimeListStateType {
    case idle,  // 一般状态
    willCreateItem, // 松开将会显示创建 Cell
    createItem,    // 创建 cell
    showArchive   // 松手切换到归档的界面
}

class TCTimeListStateManager: NSObject {
    
    // 和滑动相关联
    let tableview:UITableView
    let TCTimeListContentOffset = "contentOffset"
    var tableviewOriginalContentInset = UIEdgeInsets.zero
    var state:TCTimeListStateType {
        get {
            return self.currentState
        }
        set {
            let oldStatue = self.currentState
            if newValue == oldStatue {
                return ;
            }
            
            self.currentState = newValue
            
            if newValue == .createItem {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    },  completion: { (finished) in
                        if finished {
                            self.tableview.isScrollEnabled = false
                            guard let closure = self.showCreateItemClosure else {
                                return ;
                            }
                            closure()
                        }
                    })
                }
            }
        }
    }
    private var currentState:TCTimeListStateType
    var showArchiveVCClosure:(()->(Void))?
    var showCreateItemClosure:(()->(Void))?
    var insetT:CGFloat = 0
    
    // 默认状态分割线
    var idleCriticalValue:CGFloat {
        get {
            return createItemHeight / 2
        }
    }
    // 创建 item 分割线
    var createItemCriticalValue:CGFloat {
        get {
            return -(createItemHeight)
        }
    }
    
    init(with tableview:UITableView) {
        currentState = .idle
        self.tableview = tableview
        tableviewOriginalContentInset = self.tableview.contentInset
        super.init()
        self.addObservers()
    }
    
    deinit {
        self.tableview.removeObserver(self, forKeyPath: TCTimeListContentOffset, context: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == TCTimeListContentOffset && change != nil {
            let offset:CGPoint = change![NSKeyValueChangeKey.newKey] as? CGPoint ?? CGPoint.zero
            self.updateItemView(with: offset)
        }
    }
    
    func addObservers() {
        self.tableview.addObserver(self, forKeyPath: TCTimeListContentOffset, options: [.new, .old], context: nil)
    }
}

// MARK: - observable
extension TCTimeListStateManager {
    func updateItemView(with contentOffset:CGPoint) {
        // 更新 status
        updateStatus(with: contentOffset)
    }
    
    /// 更新页面的状态
    ///
    /// - Parameter contentOffset: 偏移量
    func updateStatus(with contentOffset:CGPoint) {
        // 大于 0 的时候直接返回，不去更新对应的内容
        if contentOffset.y > createItemHeight {
            return ;
        }
        
        // 被拖动的时候
        if self.tableview.isDragging {
            self.updateDraggingStatus(with: contentOffset)
        } else {
            self.updateNoDraggingStatus(with: contentOffset)
        }
    }
}

// MARK: - update UI After Dragging
extension TCTimeListStateManager {
    /// 拖动的时候的更新状态
    ///
    /// - Parameter contentOffst: 偏移量
    func updateDraggingStatus(with contentOffset:CGPoint) {
        
        let contentOffsetY = contentOffset.y
        // 变成归档的状态
        if contentOffsetY < createItemCriticalValue &&
            self.state != .showArchive {
            self.state = .showArchive
        }
        
        // 转变成新建内容
        if createItemCriticalValue < contentOffsetY &&
            contentOffsetY < idleCriticalValue &&
            self.state != .willCreateItem {
            self.state = .willCreateItem
        }
        
        if idleCriticalValue < contentOffsetY &&
            self.state != .idle {
            self.state = .idle
        }
    }
    
    /// 松手的时候的更新状态
    ///
    /// - Parameter contentOffst: 偏移量
    func updateNoDraggingStatus(with contentOffset:CGPoint) {
        if self.state == .willCreateItem {
            self.state = .createItem
            return ;
        }
        
        if self.state == .createItem {
            return ;
        }
        
        if self.state == .showArchive {
            guard let closuer = self.showArchiveVCClosure else {
                return ;
            }
            closuer();
        }
    }
}
