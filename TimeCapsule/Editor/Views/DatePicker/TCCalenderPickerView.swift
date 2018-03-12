//
//  TCCalenderPickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCCalenderPickerView: UIView {
    let monthPickerView:TCMonthPickerView = TCMonthPickerView.init(frame: .zero)
    let dataPickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)
    var updateMonthClosuer:((TCMonthClickStatus)->(TCEventShowModel))? {
        set {
            self.updateMonthClosuer = newValue
            if newValue != nil {
                monthPickerView.updateMonthClosuer = {(status:TCMonthClickStatus) -> (TCEventShowModel) in
                    return newValue!(status)
                }
                dataPickerView.updateMonthClosuer = {(status:TCMonthClickStatus) -> (TCEventShowModel) in
                    return newValue!(status)
                }
            }
        }
        
        get {
            return self.updateMonthClosuer
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(monthPickerView)
        addSubview(dataPickerView)
        
        self.backgroundColor = UIColor.white
    }
    
    convenience init(with showModel:TCEventShowModel) {
        self.init(frame: .zero)
        monthPickerView.updateCurrentLabel(model: showModel)
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
