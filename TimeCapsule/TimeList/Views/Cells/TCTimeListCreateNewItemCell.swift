//
//  TCTimeLIstCreateNewItemCell.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/27.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListCreateNewItemCell: UITableViewCell {
    
    let offsetX:CGFloat = 20
    let offsetY:CGFloat = 5
    let createItemView = TCTimeListCreateContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(createItemView)
        self.backgroundColor = tcBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let createItemViewSize = CGSize.init(width: self.contentView.bounds.size.width - offsetX * 2,
                                             height: self.contentView.bounds.size.height - offsetY * 2)
        let createItemOrigin = CGPoint.init(x: offsetX, y: offsetY)
        
        createItemView.frame = CGRect.init(origin: createItemOrigin, size: createItemViewSize)
    }
    
    func reset() {
        self.createItemView.clear()
    }

}
