//
//  TCDatePickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 12/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCDatePickerView: UIView {
    
    var dateGroupView = TCDatePickerGroupView()
    var selectedLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(dateGroupView)
        setupView()
    }
    
    func setupView() {
        dateGroupView.frame = CGRect(x: 16, y: 0, width: self.bounds.size.width - 16 * 2, height: self.bounds.height)
    }
    
    func update(with showModel:TCEventShowModel) {
        self.dateGroupView.update(with: showModel)
        self.dateGroupView.setNeedsLayout()
    }
    
    func clear() {
        self.dateGroupView.clear()
    }
    
    func select(date:Int) {
        self.dateGroupView.updateSelected(day: date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
