//
//  TCCalenderPickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCCalenderPickerView: UIView {
    
    var initShowModel:TCEventShowModel
    var currentShowModel:TCEventShowModel
    
    let monthPickerView:TCMonthPickerView = TCMonthPickerView.init(frame: .zero)
    let dataPickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)

    override init(frame: CGRect) {
        initShowModel = TCEventShowModel()
        currentShowModel = TCEventShowModel()
        super.init(frame: frame)
        addSubview(monthPickerView)
        addSubview(dataPickerView)
        self.backgroundColor = UIColor.white
        
        monthPickerView.updateMonthClosuer = { (status:TCMonthClickStatus) -> (TCEventShowModel) in
            if status == .previous {
                self.currentShowModel.manager.date = Date.init(timeInterval: TimeInterval(-3600 * 24 * (self.currentShowModel.manager.currentMonthDay)) , since: (self.currentShowModel.manager.date))
            } else {
                self.currentShowModel.manager.date = Date.init(timeInterval: TimeInterval(3600 * 24 * (self.currentShowModel.manager.currentMonthDay)) , since: (self.currentShowModel.manager.date))
            }
            
            return self.currentShowModel
        }
    }
    
    convenience init(with showModel:TCEventShowModel) {
        self.init(frame: .zero)
        self.initShowModel = showModel
        self.currentShowModel = showModel
        self.update(with: showModel)
    }
    
    func update(with showModel:TCEventShowModel) {
        monthPickerView.updateCurrentLabel(model: showModel)
        dataPickerView.update(with: showModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthPickerView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30)
        dataPickerView.frame = CGRect(x: 0, y: monthPickerView.frame.height, width: self.bounds.size.width, height: self.bounds.size.height - monthPickerView.frame.height)
        
    }
}
