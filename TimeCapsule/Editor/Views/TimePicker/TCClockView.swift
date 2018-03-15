//
//  TCClockView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 14/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCClockView: UIView {
    var timeButtonArray = [UIButton]()
    var timeLine:UIView
    
    var calculateClockStatus:TCClockPickerStatus {
        set {
            if self.status == newValue {
                return
            }
            
            self.status = newValue
            for (index, button) in self.timeButtonArray.enumerated() {
                button.setTitle(status == .hour ? self.hourStatus == .AM ? "\(index)" : "\((index + 12)) " : "\((index) * 5)", for: .normal)
            }
        } get {
            return self.status
        }
    }
    private var status:TCClockPickerStatus
    
    var calculateHourStatus:TCClockHourStatus {
        set {
            if status != .hour || self.hourStatus == newValue {
                return
            }
            self.hourStatus = newValue
            
            for (index, button) in self.timeButtonArray.enumerated() {
                button.setTitle(self.hourStatus == .AM ? "\(index)" : "\(index + 12) ", for: .normal)
            }
        }
        get {
            return self.hourStatus
        }
    }
    
    private var hourStatus:TCClockHourStatus
    
    var clickButtonClosuer:((_ time:Int)->())?
    
    var selectButton:UIButton?
    var currentRadius:Int
    
    var clickHourClosur:((Int)->())?
    var clickMinuteClosur:((Int)->())?
    
    init(with status:TCClockPickerStatus = .hour, hourStatus:TCClockHourStatus) {
        timeLine = UIView.init(frame: CGRect.zero)
        timeLine.backgroundColor = UIColor.yellow
        timeLine.layer.anchorPoint = CGPoint(x:0.1, y:0.9)
        currentRadius = 0
        self.status = status
        self.hourStatus = hourStatus
        
        super.init(frame: .zero)
        
        timeLine.layer.position = CGPoint(x: self.bounds.width / 2.0 - self.timeLine.frame.width / 2.0, y: self.bounds.height / 2.0)

        for index in 0 ..< 12 {
            let button = UIButton.init(type: .custom)
            button.setTitle(status == .hour ? "\(index)" : "\((index) * 5)", for: .normal)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.orange, for: .selected)
            button.setTitleColor(UIColor.black, for: .selected)
            addSubview(button)
            button.tag = index
            button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
            timeButtonArray.append(button)
            button.backgroundColor = UIColor.red
        }
        
        addSubview(timeLine)
        setupAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let WH:CGFloat = 40
        let size = CGSize.init(width: WH, height: WH)
        let radius:CGFloat = self.bounds.width / 2 - size.width / 2
        let perRadius = CGFloat.pi / 180
        for (index, button) in timeButtonArray.enumerated() {
            let correctRadius:CGFloat = perRadius * CGFloat((-90 + index * 30))
            let offsetY = sin(correctRadius) * radius
            let offsetX = cos(correctRadius) * radius
            let originX = self.bounds.width / 2 - size.width / 2 + offsetX
            let originY = self.bounds.height / 2 - size.width / 2 + offsetY
            button.frame = CGRect(origin: CGPoint(x:originX, y:originY), size: size)
        }

        timeLine.frame = CGRect.init(x: CGFloat(self.bounds.width / 2 - 10), y: WH, width: 20.0, height: radius)
    }
    
    func setupAction() {
//        WARNING:晚点做
//        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(moveAnimation(gesture:)))
//        self.isUserInteractionEnabled = true;
//        self.addGestureRecognizer(pan)
    }
    
//    @objc func moveAnimation(gesture:UIPanGestureRecognizer) {
//        let point = gesture.location(in: self)
//        let centerPoint = CGPoint.init(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
//        print(self.center)
//        let offset:CGPoint = CGPoint(x:CGFloat(point.x - centerPoint.x), y:CGFloat(point.y - centerPoint.y))
//        let perRadius = CGFloat.pi / 180
//
//        var radius:CGFloat = 0.0;
//        // 右下角
//        if offset.x > 0 && offset.y >= 0 {
//            radius = atan(offset.y / offset.x) / perRadius
//        }
//
//        // 左下角
//        if offset.x <= 0 && offset.y > 0 {
//            radius = 90 + atan(abs(offset.x) / offset.y) / perRadius
//        }
//
//        // 左上角
//        if offset.x <= 0 && offset.y < 0 {
//            radius = 180 + atan(abs(offset.y) / abs(offset.x)) / perRadius
//        }
//
//        // 右上角
//        if offset.x > 0 && offset.y <= 0 {
//            print(offset)
//            radius = 270 + atan(offset.x / abs(offset.y)) / perRadius
//        }
//
//        print(radius)
//
//    }
    
    @objc func click(button:UIButton) {
        self.select(buttonIndex: button.tag)
        if clickButtonClosuer != nil {
            clickButtonClosuer!(button.tag)
        }
        
        if clickHourClosur != nil && status == .hour {
            clickHourClosur!(self.hourStatus == .AM ? button.tag : 12 + button.tag)
        }
        
        // 暂时着这样，之后再精确到分钟
        if clickMinuteClosur != nil && status == .minutes {
            clickMinuteClosur!(button.tag * 5)
        }
    }
    
    func select(buttonIndex:Int) {
        if buttonIndex < 0 || buttonIndex >= 12 {
            return
        }
        self.clear()
        
        self.timeButtonArray[safe:buttonIndex]?.isSelected = true
        self.selectButton = self.timeButtonArray[safe:buttonIndex]
    }
    
    func clear() {
        selectButton?.isSelected = false
    }
}
