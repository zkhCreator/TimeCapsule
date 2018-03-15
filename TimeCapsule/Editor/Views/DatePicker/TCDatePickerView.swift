//
//  TCDatePickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 12/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCDatePickerView: UIView {

    var buttonArray = [UIButton]()
    var selectedButton:UIButton?
    
    var firstDayWeekday = TCWeekday.Sunday
    var updateSelectedDate:((Int)->())?
    
    // MARK:init obj
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0 ..< 31 {
            let button = UIButton.init(type: .custom)
            button.tag = i
            button.setTitle("\(i + 1)", for: .normal)
            button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.black, for: .normal)
            buttonArray.append(button)
            addSubview(button)
        }
    }
    
    func setupLabelsFrame() {
        var currentDayOffset = firstDayWeekday.rawValue - 1
        let viewWidth = self.bounds.width
        let singleWidth = viewWidth / CGFloat(7)
        
        for label in buttonArray {
            let line = (currentDayOffset / 7)
            label.frame = CGRect(x: singleWidth * CGFloat(currentDayOffset % 7), y: CGFloat(line) * CGFloat(singleWidth), width: singleWidth, height: singleWidth)
            
            currentDayOffset = currentDayOffset + 1
        }
    }
    
    func update(with showModel:TCEventShowModel) {
        firstDayWeekday = showModel.manager.firstDayWeekDay
        
        for (index, label) in buttonArray.enumerated() {
            if index < showModel.manager.date.monthDay() {
                label.alpha = 1
            } else {
                label.alpha = 0;
            }
        }
    }
    
    func clear() {
        selectedButton?.backgroundColor = UIColor.clear
        selectedButton?.isSelected = false
    }

    @objc func click(button:UIButton) {
        self.updateSelected(day: button.tag + 1)
        
        if updateSelectedDate != nil {
            updateSelectedDate!(button.tag + 1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLabelsFrame()
    }
    
    func updateSelected(day:Int) {
        selectedButton?.backgroundColor = UIColor.clear
        selectedButton?.isSelected = false
        selectedButton = buttonArray[safe: day - 1]
        selectedButton?.backgroundColor = UIColor.red
        selectedButton?.isSelected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
