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
    var currentDatePickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)
    var nextDatePickerView:TCDatePickerView = TCDatePickerView.init(frame: .zero)
    
    var canUpdatePickerView:Bool = true

    override init(frame: CGRect) {
        initShowModel = TCEventShowModel()
        currentShowModel = TCEventShowModel()
        super.init(frame: frame)
        addSubview(monthPickerView)
        addSubview(currentDatePickerView)
        addSubview(nextDatePickerView)
        self.backgroundColor = UIColor.white
        
        monthPickerView.updateMonthClosuer = { (status:TCMonthClickStatus) -> (TCEventShowModel)  in
            if status == .previous {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.previousMonth()
            } else {
                self.currentShowModel.manager.date = self.currentShowModel.manager.date.nextMonth()
            }
            self.startAnimate(with: status)
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
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nextDatePickerView.frame = nextMoveToFrame
            self.currentDatePickerView.frame = currentViewMoveToFrame
        }) { (finished) in
            if finished {
                let tempPickerView = self.nextDatePickerView
                self.nextDatePickerView = self.currentDatePickerView
                self.currentDatePickerView = tempPickerView
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthPickerView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30)
        if canUpdatePickerView {
            canUpdatePickerView = false
            currentDatePickerView.frame = CGRect(x: 0, y: monthPickerView.frame.height, width: self.bounds.size.width, height: self.bounds.size.height - monthPickerView.frame.height)
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
        
        return CGRect(x: offsetX, y: monthPickerView.frame.height, width: self.bounds.size.width, height: self.bounds.size.height - monthPickerView.frame.height)
    }
}
