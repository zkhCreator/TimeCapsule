//
//  TCTimeLIstCreateNewItemCell.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/27.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeLIstCreateNewItemCell: UITableViewCell {
    
    let createItemView = TCTimeListCreateContentView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(createItemView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createItemView.frame = self.bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
