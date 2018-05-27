//
//  TCTagView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/26.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTagView: UIView {
    
    var gradientLayer:CAGradientLayer?
    var fromColor = UIColor.clear
    var endColor = UIColor.clear
    
    init(frame: CGRect, fromColor:UIColor, endColor:UIColor) {
        self.fromColor = fromColor
        self.endColor = endColor
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.gradientLayer?.removeFromSuperlayer()
        self.gradientLayer = CAGradientLayer.init(startColor: fromColor, endColor: endColor, size: self.bounds.size)
        self.layer.addSublayer(gradientLayer!)
        self.layer.cornerRadius = self.frame.width > self.frame.height ? self.frame.width : self.frame.height
        self.layer.borderColor = UIColor.init(hexColor: 0xf5f5f5).cgColor
    }
}
