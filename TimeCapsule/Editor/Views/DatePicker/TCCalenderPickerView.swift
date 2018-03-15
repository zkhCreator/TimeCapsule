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
    var weekdayArray = [UILabel]()
    
    var currentDatePickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)
    var nextDatePickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)
    
    var canUpdatePickerView:Bool = true
    var selectedDateClosuer:((TCEventShowModel)->())?

    override init(frame: CGRect) {
        initShowModel = TCEventShowModel()
        currentShowModel = TCEventShowModel()
        super.init(frame: frame)
        addSubview(monthPickerView)
        addSubview(currentDatePickerView)
        addSubview(nextDatePickerView)
        nextDatePickerView.alpha = 0
        self.backgroundColor = UIColor.white
        
        // 顶部静止的 weekday
        for dayTitle in TCTimeAdapter.showSunFirstWeekOmissionName() {
            let label = UILabel.init()
            label.textAlignment = .center
            label.text = dayTitle
            addSubview(label)
            weekdayArray.append(label)
        }
        
        monthPickerView.updateMonthClosuer = { (status:TCMonthClickStatus) -> (TCEventShowModel)  in
            if status == .previous {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.previousMonth()
            } else {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.nextMonth()
            }
            self.startAnimate(with: status)
            return self.currentShowModel
        }
        
        currentDatePickerView.updateSelectedDate = {[unowned self](selecteDay:Int) in
            let tempShowModel = self.currentShowModel.manager
            self.currentShowModel.manager.date = Date.customDate(year: tempShowModel.year,
                                                            month: tempShowModel.month.rawValue,
                                                            day: selecteDay,
                                                            hour: 0, minute: 0, timeZone: tempShowModel.comp.timeZone!)
            self.initShowModel = self.currentShowModel
            if self.selectedDateClosuer != nil {
                self.selectedDateClosuer!(self.currentShowModel)
            }
        }
        
        nextDatePickerView.updateSelectedDate = currentDatePickerView.updateSelectedDate
    }
    
    convenience init(with showModel:TCEventShowModel) {
        self.init(frame: .zero)
        self.initShowModel = showModel
        self.currentShowModel = showModel
        self.update(with: showModel)
    }
    
    func update(with showModel:TCEventShowModel) {
        monthPickerView.updateCurrentLabel(model: showModel)
        currentDatePickerView.updateSelected(day: showModel.manager.day)
        currentDatePickerView.update(with: showModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimate(with status:TCMonthClickStatus) {
        
        let currentMoveDirection:TCCustomViewPosition = status == .next ? .left : .right
        let currentViewMoveToFrame = createNewFrame(with: currentMoveDirection)
        let nextMoveFromDirection:TCCustomViewPosition = status == .next ? .right : .left
        let nextMoveFromFrame = createNewFrame(with: nextMoveFromDirection)
        let nextMoveToFrame = createNewFrame(with: .middle)
        
        nextDatePickerView.frame = nextMoveFromFrame
        nextDatePickerView.update(with: self.currentShowModel)
        nextDatePickerView.alpha = 0
        
        if self.currentShowModel.monthString == self.initShowModel.monthString {
            nextDatePickerView.updateSelected(day: self.initShowModel.manager.day)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nextDatePickerView.frame = nextMoveToFrame
            self.currentDatePickerView.frame = currentViewMoveToFrame
            self.nextDatePickerView.alpha = 1
            self.currentDatePickerView.alpha = 0
        }) { (finished) in
            if finished {
                self.currentDatePickerView.clear()
                let tempPickerView = self.nextDatePickerView
                self.nextDatePickerView = self.currentDatePickerView
                self.currentDatePickerView = tempPickerView
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthPickerView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30)
        
        let offsetX:CGFloat = 16
        let viewWidth = self.bounds.size.width - offsetX * 2
        
        for (index, label) in weekdayArray.enumerated() {
            label.frame = CGRect.init(x: CGFloat(index) * viewWidth / CGFloat(weekdayArray.count) + offsetX,
                                      y: self.monthPickerView.bounds.size.height,
                                      width: (viewWidth) / CGFloat(weekdayArray.count),
                                      height: 16)
        }
        
        if canUpdatePickerView {
            canUpdatePickerView = false
            currentDatePickerView.frame = self.createNewFrame(with: .middle)
        }
        
        
    }
    
    func createNewFrame(with position:TCCustomViewPosition) -> CGRect {
        var offsetX:CGFloat = 0
        switch position {
        case .left:
            offsetX = -self.bounds.width
        case .middle:
            offsetX = 0
        case .right:
            offsetX = self.bounds.width
            
        }
        
        return CGRect(x: offsetX,
                      y: weekdayArray.first!.frame.origin.y + weekdayArray.first!.frame.size.height + 16,
                      width: self.bounds.size.width,
                      height: self.bounds.size.height - monthPickerView.frame.height - weekdayArray.first!.frame.origin.y + weekdayArray.first!.frame.size.height - 16)
    }
}
