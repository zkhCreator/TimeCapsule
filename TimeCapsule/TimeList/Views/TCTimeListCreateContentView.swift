//
//  TCTimeListCreateContentView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/26.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListCreateContentView: UIView {

    var gradientLayer : CAGradientLayer = CAGradientLayer.init(size: CGSize.zero);
    lazy var tagContainer:TCTagListContainerView = TCTagListContainerView.init(frame: CGRect.zero, maxHeight: 15)
    
    var editTimeTextField:UITextField = {
        let field = UITextField.init()
        let attributePlaceHolder = NSAttributedString.init(string: "设置提醒", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(hexColor: 0xf5f5f5, alpha:0.6),NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
        field.attributedPlaceholder = attributePlaceHolder
        return field
    }()
    
    var thingTextField:UITextField = {
        let field = UITextField.init()
        let attributePlaceHolder = NSAttributedString.init(string: "要做的事情", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(hexColor: 0xf5f5f5, alpha:0.6),NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)])
        field.attributedPlaceholder = attributePlaceHolder
        return field
    }()
    
    var detailButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "cell-detail-normal"), for: .normal)
        button.setImage(UIImage.init(named: "cell-detail-selected"), for: .selected)
        button.sizeToFit()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.layer.addSublayer(self.gradientLayer)
        self.addSubview(tagContainer)
        self.addSubview(editTimeTextField)
        self.addSubview(thingTextField)
        self.addSubview(detailButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.detailButton.frame = CGRect.init(origin: CGPoint.init(x: self.bounds.maxX - 5 - self.detailButton.frame.size.width,
                                                                   y: self.bounds.maxY - 5 - self.detailButton.frame.size.height),
                                              size: self.detailButton.frame.size);
        
        self.editTimeTextField.frame = CGRect.init(x: 10, y: 8, width: self.bounds.size.width / 2, height: 20)
        self.thingTextField.frame = CGRect.init(x: self.editTimeTextField.frame.minX,
                                                y: self.editTimeTextField.frame.maxY,
                                                width: self.detailButton.frame.minX - self.editTimeTextField.frame.minX,
                                                height: 24)
        self.tagContainer.sizeToFit()
        self.tagContainer.frame = CGRect.init(origin: CGPoint.init(x: self.bounds.maxX - 5 - self.tagContainer.frame.size.width,
                                                                   y: 5),
                                              size: self.tagContainer.frame.size)
        self.gradientLayer.frame = self.bounds
    }
    
}
