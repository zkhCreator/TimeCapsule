//
//  TCBasicListTableViewCell.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/6/1.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit
import MCSwipeTableViewCell

class TCBasicListTableViewCell: MCSwipeTableViewCell {

//    let pan:UIPanGestureRecognizer = UIPanGestureRecognizer.init()
//    var isDragging = false
//    var screenShootView:UIImageView?
//
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
//        pan.addTarget(self, action: #selector(handleGesture(gesture:)))
//        pan.delegate = self
//        self.addGestureRecognizer(pan)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension TCBasicListTableViewCell {
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer is UIPanGestureRecognizer {
//            let pan = gestureRecognizer as! UIPanGestureRecognizer
//            let velocity = pan.velocity(in: self)
//
//            print(velocity)
//            return true
//        }
//
//        return false
//    }
//}
//
//extension TCBasicListTableViewCell {
//    @objc
//    func handleGesture(gesture:UIPanGestureRecognizer) {
//        let status:UIGestureRecognizerState = gesture.state
//
//        // 开始的时候生成对应的遮罩层，并修改状态
//        if status == .began || status == .changed {
//            isDragging = true
//
//
//
//            return ;
//        }
//
//        if status == .cancelled || status == .ended {
//            isDragging = false
//
//            return ;
//        }
//    }
//}
//
//// MARK: - UI
//extension TCBasicListTableViewCell {
//    func setSwipeView() {
//        // 判断是否已经生成或者重复生成
//        if screenShootView != nil {
//            return
//        }
//
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
//        self.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let currentScreenShootImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        screenShootView = UIImageView.init(image: currentScreenShootImage)
//        screenShootView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        screenShootView?.backgroundColor = UIColor.clear
//
//        self.addSubview(screenShootView!)
//
//
//    }
//}
