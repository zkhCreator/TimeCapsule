//
//  TCTimeListCreateNewItemView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/22.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

enum TCTimeListCreateNewItemViewStateType {
    case idle,  // 一般状态
    willCreateItem, // 松开将会显示创建 Cell
    createItem,    // 创建 cell
    showArchive   // 松手切换到归档的界面
}

class TCTimeListCreateNewItemView: UIView {
    
    // 和滑动相关联
    weak var scrollView:UIScrollView?
    let TCTimeListContentOffset = "contentOffset"
    let TCTimeListContentSize = "contentSize"
    let TCTimeListPanState = "state"
    var state:TCTimeListCreateNewItemViewStateType {
        get {
            return self.currentState
        }
        set {
            let oldStatue = self.currentState
            if newValue == oldStatue {
                return ;
            }
            
            self.currentState = newValue
            
            if newValue == .idle && oldStatue == .createItem {
                DispatchQueue.main.async {
                    guard let currentScrollView = self.scrollView,
                        let originalInset = self.scrollViewOriginalInset else {
                        return
                    }
                    UIView.animate(withDuration: 0.3, animations: {
                        currentScrollView.contentInset = originalInset
                        currentScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
                    });
                }
            }
            
            if newValue == .createItem {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, animations: {
                        guard let currentScrollview = self.scrollView else {
                            return ;
                        }
                        let top = (self.scrollViewOriginalInset?.top ?? 0) + self.frame.size.height
                        self.scrollView?.contentInset.top = top
                        
                        var contentOffset = currentScrollview.contentOffset
                        contentOffset.y = -top
                        currentScrollview.setContentOffset(contentOffset, animated: false)
                        
                        guard let closure = self.showCreateItemClosure else {
                            return ;
                        }
                        
                        closure()
                    })
                }
            }
            
        }
    }
    private var currentState:TCTimeListCreateNewItemViewStateType
    var scrollViewOriginalInset:UIEdgeInsets?
    var showArchiveVCClosure:(()->(Void))?
    var showCreateItemClosure:(()->(Void))?
    var insetT:CGFloat = 0
    
    let contentView = TCTimeListCreateContentView()
    
    // 默认状态分割线
    var idleCriticalValue:CGFloat {
        get {
            return self.frame.size.height / 2
        }
    }
    // 创建 item 分割线
    var createItemCriticalValue:CGFloat {
        get {
            return (self.frame.size.height * 2)
        }
    }
    
    override init(frame: CGRect) {
        currentState = .idle
        super.init(frame: frame)
        self.addSubview(contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.removeObserver()
        if newSuperview != nil && newSuperview is UIScrollView {
            self.frame = CGRect.init(x: 0, y: -60, width: newSuperview?.bounds.width ?? 0, height: 60);
            self.scrollView = newSuperview as? UIScrollView
            self.scrollViewOriginalInset = self.scrollView?.contentInset
            self.addObservers()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == TCTimeListContentOffset && change != nil {
            let offset:CGPoint = change![NSKeyValueChangeKey.newKey] as? CGPoint ?? CGPoint.zero
            self.updateItemView(with: offset)
        }
    }
    
    func addObservers() {
        if self.scrollView == nil {
            return
        }
        
        let scrollView = self.scrollView!
        scrollView.addObserver(self, forKeyPath: TCTimeListContentOffset, options: [.new, .old], context: nil)
        scrollView.addObserver(self, forKeyPath: TCTimeListContentSize, options: [.new, .old], context: nil)
        scrollView.panGestureRecognizer.addObserver(self, forKeyPath: TCTimeListPanState, options: [.new, .old], context: nil)
        
    }
    
    func removeObserver() {
        self.scrollView?.removeObserver(self, forKeyPath: TCTimeListContentSize)
        self.scrollView?.removeObserver(self, forKeyPath: TCTimeListContentOffset)
        self.scrollView?.panGestureRecognizer.removeObserver(self, forKeyPath: TCTimeListPanState)
    }
}

// MARK: - observable
extension TCTimeListCreateNewItemView {
    func updateItemView(with contentOffset:CGPoint) {
        // 更新 status
        updateStatus(with: contentOffset)
    }
    
    /// 更新页面的状态
    ///
    /// - Parameter contentOffset: 偏移量
    func updateStatus(with contentOffset:CGPoint) {
        // 大于 0 的时候直接返回，不去更新对应的内容
        if contentOffset.y > 0 {
            return ;
        }
        
        guard let currentScrollView:UIScrollView = self.scrollView else {
            return ;
        }
        
        // 被拖动的时候
        if currentScrollView.isDragging {
            self.updateDraggingStatus(with: contentOffset)
        } else {
            self.updateNoDraggingStatus(with: contentOffset)
        }
    }
}

// MARK: - update UI After Dragging
extension TCTimeListCreateNewItemView {
    /// 拖动的时候的更新状态
    ///
    /// - Parameter contentOffst: 偏移量
    func updateDraggingStatus(with contentOffset:CGPoint) {
        let absContentOffsetY = abs(contentOffset.y)
        // 变成归档的状态
        if absContentOffsetY > createItemCriticalValue &&
            self.state != .showArchive {
            self.state = .showArchive
        }
        
        print("--------------")
        print("state: \(self.state)")
        print("absContentOffsetY: \(absContentOffsetY)")
        print("idleCriticalValue: \(idleCriticalValue)")
        print("createItemCriticalValue: \(createItemCriticalValue)")
        print("--------------")
        // 转变成新建的内容
        if idleCriticalValue < absContentOffsetY &&
            absContentOffsetY < createItemCriticalValue &&
            self.state != .willCreateItem {
            self.state = .willCreateItem
            return ;
        }
        
        if idleCriticalValue > absContentOffsetY && self.state != .idle {
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
