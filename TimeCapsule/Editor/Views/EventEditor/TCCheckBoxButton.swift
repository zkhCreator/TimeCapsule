//
//  TCCheckBoxButton.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/4/1.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCCheckBoxButton: UIView {
    let checkbox = UIButton.init(type: .custom)
    let contentLabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        checkbox.setImage(UIImage.init(named: "checkboxUnSelected"), for: .normal)
        checkbox.setImage(UIImage.init(named: "checkBoxSelected"), for: .selected)
        self.addSubview(checkbox)
        self.addSubview(contentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkbox.frame = CGRect.init(x: 0, y: 0, width: baseButtonFrame, height: baseButtonFrame)
        contentLabel.frame = CGRect.init(x: baseButtonFrame + smallMarginOffset, y: 0, width: self.bounds.size.width - checkbox.frame.size.width - smallMarginOffset, height: checkbox.frame.height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize.init(width: contentLabel.frame.maxX, height: contentLabel.frame.maxY)
    }

}
