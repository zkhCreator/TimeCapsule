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
    
    var monthPickerView:TCMonthPickerView?
    var weekdayArray = [UILabel]()
    
    var currentDatePickerView:TCDatePickerView?
    var nextDatePickerView:TCDatePickerView?
    
    var selectedDateClosuer:((TCEventShowModel)->())?
    
    let weekHeight = marginOffset

    override init(frame: CGRect) {
        initShowModel = TCEventShowModel()
        currentShowModel = TCEventShowModel()

        super.init(frame: frame)
        // 月份选择器
        monthPickerView = TCMonthPickerView.init(frame:CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        addSubview(monthPickerView!)
        
        // 星期指示器
        // 顶部静止的 weekday
        for dayTitle in TCTimeAdapter.showSunFirstWeekOmissionName() {
            let label = UILabel.init()
            label.textAlignment = .center
            label.text = dayTitle
            label.backgroundColor = UIColor.white
            addSubview(label)
            weekdayArray.append(label)
        }
        
        let viewWidth = self.bounds.size.width - marginOffset * 2
        for (index, label) in weekdayArray.enumerated() {
            label.frame = CGRect.init(x: CGFloat(index) * viewWidth / CGFloat(weekdayArray.count) + marginOffset,
                                      y: self.monthPickerView!.bounds.size.height,
                                      width: (viewWidth) / CGFloat(weekdayArray.count),
                                      height: weekHeight)
        }
        
        currentDatePickerView = TCDatePickerView.init(frame:self.createNewFrame(with: .middle))
        nextDatePickerView = TCDatePickerView.init(frame:self.createNewFrame(with: .right))
        
        addSubview(currentDatePickerView!)
        addSubview(nextDatePickerView!)
        nextDatePickerView?.alpha = 0
        self.backgroundColor = UIColor.white
        
        self.setupAction()
    }
    
    func setupAction() {
        
        let directionArray = [UISwipeGestureRecognizerDirection.left, .right]
        for direct in directionArray {
            let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(with:)))
            swipe.direction = direct
            
            let swipe1 = UISwipeGestureRecognizer.init(target: self, action: #selector(swipe(with:)))
            swipe1.direction = direct
            
            currentDatePickerView?.addGestureRecognizer(swipe)
            nextDatePickerView?.addGestureRecognizer(swipe1)
        }
        
        monthPickerView?.updateMonthClosuer = { (status:TCMonthClickStatus) -> (TCEventShowModel)  in
            if status == .previous {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.previousMonth()
            } else {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.nextMonth()
            }
            self.startAnimate(with: status)
            return self.currentShowModel
        }
        
        currentDatePickerView?.updateSelectedDate = {[unowned self](selecteDay:Int) in
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
        
        nextDatePickerView?.updateSelectedDate = currentDatePickerView?.updateSelectedDate
    }
    
    func update(with showModel:TCEventShowModel) {
        initShowModel = showModel
        currentShowModel = showModel
        monthPickerView?.updateCurrentLabel(model: showModel)
        currentDatePickerView?.updateSelected(day: showModel.manager.day)
        currentDatePickerView?.update(with: showModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swipe(with gesture:UISwipeGestureRecognizer) {
        print(gesture.direction)
        
        let updateStatus:TCMonthClickStatus = (gesture.direction == .left) ? .next : .previous;
        if updateStatus == .previous {
            self.currentShowModel.manager.date = self.currentShowModel.manager.date.previousMonth()
        } else {
            self.currentShowModel.manager.date = self.currentShowModel.manager.date.nextMonth()
        }
        
        self.monthPickerView?.updateCurrentLabel(model: self.currentShowModel)
        startAnimate(with: updateStatus)
    }
    
    func startAnimate(with status:TCMonthClickStatus) {
        
        let currentMoveDirection:TCCustomViewPosition = status == .next ? .left : .right
        let currentViewMoveToFrame = createNewFrame(with: currentMoveDirection)
        let nextMoveFromDirection:TCCustomViewPosition = status == .next ? .right : .left
        let nextMoveFromFrame = createNewFrame(with: nextMoveFromDirection)
        let nextMoveToFrame = createNewFrame(with: .middle)
        
        nextDatePickerView?.frame = nextMoveFromFrame
        nextDatePickerView?.update(with: self.currentShowModel)
        nextDatePickerView?.alpha = 0
        
        if self.currentShowModel.monthString == self.initShowModel.monthString &&
            self.currentShowModel.yearString == self.initShowModel.yearString {
            nextDatePickerView?.updateSelected(day: self.initShowModel.manager.day)
        }
        
        currentDatePickerView?.isUserInteractionEnabled = false
        nextDatePickerView?.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nextDatePickerView?.frame = nextMoveToFrame
            self.currentDatePickerView?.frame = currentViewMoveToFrame
            self.nextDatePickerView?.alpha = 1
            self.currentDatePickerView?.alpha = 0
        }) { (finished) in
            if finished {
                self.currentDatePickerView?.clear()
                let tempPickerView = self.nextDatePickerView
                self.nextDatePickerView = self.currentDatePickerView!
                self.currentDatePickerView = tempPickerView
                self.currentDatePickerView?.isUserInteractionEnabled = true
                self.nextDatePickerView?.isUserInteractionEnabled = true
            }
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
                      y: (weekdayArray.first?.frame.maxY)! + marginOffset,
                      width: self.bounds.size.width,
                      height: self.bounds.size.height - monthPickerView!.frame.height - (weekdayArray.first?.frame.maxY)! - marginOffset)
    }
}
