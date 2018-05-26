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
    
    weak var scrollView:UIScrollView?
    let TCTimeListContentOffset = "contentOffset"
    let TCTimeListContentSize = "contentSize"
    let TCTimeListPanState = "state"
    var state:TCTimeListCreateNewItemViewStateType = .idle
    var scrollViewOriginalInset:UIEdgeInsets?
    var showArchiveVCClosure:(()->(Void))?
    
    // 默认状态分割线
    var idleCriticalValue:CGFloat {
        get {
            return self.frame.size.height / 2
        }
    }
    // 创建 item 分割线
    var createItemCriticalValue:CGFloat {
        get {
            return (self.frame.size.height * 1.5)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.removeObserver()
        if newSuperview != nil && newSuperview is UIScrollView {
            self.frame = CGRect.init(x: 0, y: -44, width: newSuperview?.bounds.width ?? 0, height: 44);
            self.scrollView = newSuperview as? UIScrollView
            self.scrollViewOriginalInset = (self.scrollView?.contentInset)!
            self.addObservers()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == TCTimeListContentOffset && change != nil {
            let offset:CGPoint = change![NSKeyValueChangeKey.newKey] as? CGPoint ?? CGPoint.zero
            self.updateItemView(with: offset)
        }
        
        if keyPath == TCTimeListPanState && change != nil {
            let stateValue = change![NSKeyValueChangeKey.newKey] as! Int
            
            // 无效 state
            if stateValue > UIGestureRecognizerState.failed.rawValue ||
                stateValue < UIGestureRecognizerState.possible.rawValue {
                return ;
            }
            
            if stateValue != UIGestureRecognizerState.failed.rawValue {
                self.scrollView?.contentOffset.y += (self.scrollView?.contentInset.top)!
                self.scrollView?.contentInset = UIEdgeInsets.zero
                return
            }
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

extension TCTimeListCreateNewItemView {
    func updateItemView(with contentOffset:CGPoint) {
        // 更新 status
        updateStatus(with: contentOffset)
        // 更新对应的 UI
        updateScrollUI();
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
    
    func updateScrollUI() {
        guard let currentScrollView:UIScrollView = self.scrollView else {
            return ;
        }
        
        if self.state == .willCreateItem  {
            // 滑动状态下不需要调整
            if currentScrollView.isDragging {
                return ;
            }
        }
    }
    
    func updateInset() {
        // 如果是默认或者普通状态不修改状态
        if self.state == .idle || self.state == .showArchive {
            return
        }
        
        guard let currentScrollView = self.scrollView else {
            return ;
        }
        
//        // 只有在需要创建的时候才设置 Inset
//        UIView.animate(withDuration: 0.5) {
//            currentScrollView.contentInset = UIEdgeInsetsMake(-(self.frame.maxY), 0, 0, 0);
//        };
//        self.scrollView?.contentInset = UIEdgeInsets(top: self.frame.size.height, left: 0, bottom: 0, right: 0);
        
    }
}

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
        
        // 转变成新建的内容
        if idleCriticalValue < absContentOffsetY &&
            absContentOffsetY < createItemCriticalValue &&
            self.state != .willCreateItem {
            self.state = .willCreateItem
            return ;
        }
        
        // 转变成默认状态
        if absContentOffsetY < idleCriticalValue &&
            self.state != .idle {
            self.state = .idle
        }
    }
    
    /// 松手的时候的更新状态
    ///
    /// - Parameter contentOffst: 偏移量
    func updateNoDraggingStatus(with contentOffset:CGPoint) {
        print("no dragging \(contentOffset)")
        if self.state == .createItem {
            return ;
        }
        
        if self.state == .showArchive {
            guard let closuer = self.showArchiveVCClosure else {
                return ;
            }
            closuer();
        }
        
        if self.state == .willCreateItem {
            self.state = .createItem
            self.showCreateItem()
        } else {
            self.state = .idle
            self.hideCreateView()
        }
    }
    
    func showCreateItem() {
        
        guard let currentScrollView = self.scrollView,
            let currentOffsetY = self.scrollView?.contentOffset.y,
            let currentInsetTop = self.scrollView?.contentInset.top else {
            return ;
        }
        
        
        UIView.animate(withDuration: 0.5) {
//            currentScrollView.contentInset = UIEdgeInsetsMake(-(self.frame.maxY), 0, 0, 0);
            currentScrollView.setContentOffset(CGPoint.init(x: 0, y: -self.frame.size.height), animated: false)
        };
        
        
    }
    
    func hideCreateView() {
        
    }
}
