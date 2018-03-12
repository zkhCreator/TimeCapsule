//
//  TCDatePickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 12/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCDatePickerView: UIView {
    
    var updateMonthClosuer:((TCMonthClickStatus)->(TCEventShowModel))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setupView() {
        let dayArray = TCTimeAdapter.showSunFirstWeekOmissionName()
        for (index, dayTitle) in dayArray.enumerated() {
            let label = UILabel.init()
            label.textAlignment = .center
            label.text = dayTitle
            label.frame = CGRect.init(x: CGFloat(index) * self.bounds.width / CGFloat(dayArray.count), y: 8, width: self.bounds.width / CGFloat(dayArray.count), height: 16)
            self.addSubview(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
