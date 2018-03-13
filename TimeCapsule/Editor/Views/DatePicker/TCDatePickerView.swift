//
//  TCDatePickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 12/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCDatePickerView: UIView {
    
    var currentDate:Int
    var selectedDate:Int
    var buttonArray = [UIButton]()
    var selectedButton:UIButton?
    
    var firstDayWeekday = TCWeekday.Sunday
    
    var selectedLabel:UILabel?
    
    override init(frame: CGRect) {
        currentDate = 1
        selectedDate = 1
        super.init(frame: frame)
        setupView()
        
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
    
    func setupView() {
        var currentDayOffset = firstDayWeekday.rawValue - 1
        let offsetX:CGFloat = 0
        let viewWidth = self.bounds.width - CGFloat(offsetX * 2)
        let singleWidth = viewWidth / CGFloat(7)
        
        for label in buttonArray {
            let line = (currentDayOffset / 7)
            label.frame = CGRect(x: offsetX + singleWidth * CGFloat(currentDayOffset % 7), y: CGFloat(line) * CGFloat(singleWidth), width: singleWidth, height: singleWidth)
            
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
    
    func select(date:Int) {
        updateSelected(day: date)
    }
    
    @objc func click(button:UIButton) {
        self.updateSelected(day: button.tag + 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
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
