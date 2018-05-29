//
//  TCTimeListMaskView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/29.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListMaskView: UIView {

    let firstCellHeight = createItemHeight
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexColor: 0xffffff, alpha: 0.6)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath.init(rect: CGRect.init(origin: CGPoint.init(x: 0,
                                                                            y: firstCellHeight),
                                                       size: CGSize.init(width: self.bounds.size.width,
                                                                         height: self.frame.height - firstCellHeight)));
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // 当透明的时候事件不进行响应
        if self.isHidden || self.alpha < 0.01 {
            return false
        }
        
        if point.y > createItemHeight {
            return true
        }
        return false
    }
}
