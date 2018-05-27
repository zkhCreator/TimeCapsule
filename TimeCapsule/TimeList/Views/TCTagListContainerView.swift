//
//  TCTagListContainerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/26.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTagListContainerView: UIView {

    var tagArray = Array<TCTagView>.init()
    var tagMaxHeight:CGFloat
    
    init(frame: CGRect, maxHeight:CGFloat = 15) {
        self.tagMaxHeight = maxHeight
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with tagArray:Array<(fromColor:UIColor, endColor:UIColor)>) {
        self.tagArray.forEach { (view) in
            view.removeFromSuperview()
        }
        
        tagArray.forEach { (fromColor:UIColor, endColor:UIColor) in
            let tagView = self.createTag(with: fromColor, endColor: endColor)
            self.tagArray.append(tagView)
            self.addSubview(tagView)
        }
    }
    
    func createTag(with fromColor:UIColor, endColor:UIColor) -> TCTagView {
        let tagView = TCTagView.init(frame: CGRect.init(origin: CGPoint.init(), size: CGSize.init(width: tagMaxHeight, height: tagMaxHeight)), fromColor: fromColor, endColor: endColor)
        return tagView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, tagView) in self.tagArray.enumerated() {
            let originPoint = CGPoint.init(x: (CGFloat(index)) * (tagMaxHeight + 5), y: 0)
            tagView.frame.origin = originPoint
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var maxWidth:CGFloat = 0;
        tagArray.forEach { (view) in
            maxWidth = view.frame.maxX
        }
        return CGSize.init(width: maxWidth, height: tagMaxHeight)
    }
}
