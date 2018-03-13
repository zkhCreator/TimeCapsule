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
    var weekdayArray = [UILabel]()
    var selectedLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        for dayTitle in TCTimeAdapter.showSunFirstWeekOmissionName() {
            let label = UILabel.init()
            label.textAlignment = .center
            label.text = dayTitle
            addSubview(label)
            weekdayArray.append(label)
        }
        addSubview(dateGroupView)
        setupView()
    }
    
    func setupView() {
        let offsetX:CGFloat = 16
        let viewWidth = self.bounds.size.width - offsetX * 2
        
        for (index, label) in weekdayArray.enumerated() {
            label.frame = CGRect.init(x: CGFloat(index) * viewWidth / CGFloat(weekdayArray.count) + offsetX,
                                      y: 8,
                                      width: (viewWidth) / CGFloat(weekdayArray.count),
                                      height: 16)
        }
        dateGroupView.frame = CGRect(x: offsetX, y: 24, width: viewWidth, height: self.bounds.height - 24)
    }
    
    func update(with showModel:TCEventShowModel) {
        self.dateGroupView.update(with: showModel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        self.dateGroupView.updateSelected(day: 12)
        self.dateGroupView.clear()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
