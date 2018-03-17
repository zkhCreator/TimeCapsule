//
//  TCClockView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 14/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCClockView: UIView {
    
    // static
    let perRadius = CGFloat.pi / 180

    // 所有的按钮
    var timeButtonArray = [UIButton]()
    // 针
    var timeLine:UIView?
    
    // 用于读写当前的钟面是小时还是分钟
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
    private var status:TCClockPickerStatus = .hour
    
    // 用于读写当前的钟面时候 AM 还是 PM
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
    private var hourStatus:TCClockHourStatus = .AM
    
    // 按钮点击之后的回调
    var clickButtonClosuer:((_ time:Int)->())?
    
    // 选中的那个按钮
    var selectButton:UIButton?
    
    var clickHourClosur:((Int)->())?
    var clickMinuteClosur:((Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupClockFace()
        setupAction()
    }
    
    func setupClockFace() {
        let WH:CGFloat = 40
        let size = CGSize.init(width: WH, height: WH)
        let radius:CGFloat = (self.bounds.width - size.width) / 2
        
        for index in 0 ..< 12 {
            let button = UIButton.init(type: .custom)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.orange, for: .selected)
            button.setTitleColor(UIColor.black, for: .selected)
            button.tag = index
            button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
            button.backgroundColor = UIColor.red
            button.layer.cornerRadius = size.width / 2.0

            let correctRadius:CGFloat = perRadius * CGFloat((-90 + index * 30))
            let offsetY = sin(correctRadius) * radius
            let offsetX = cos(correctRadius) * radius
            let originX = self.bounds.width / 2 - size.width / 2 + offsetX
            let originY = self.bounds.height / 2 - size.width / 2 + offsetY
            button.frame = CGRect(origin: CGPoint(x:originX, y:originY), size: size)
            button.setTitle(status == .hour ? "\(index)" : "\((index) * 5)", for: .normal)

            timeButtonArray.append(button)
            addSubview(button)
        }
        
        let timeLineFrame = CGRect.init(x: CGFloat((self.bounds.width - 20) / 2), y: 40, width: 20.0, height: self.bounds.width / 2 - 20)
        timeLine = UIView.init()
        timeLine?.layer.anchorPoint = CGPoint(x:0.5, y:0.88)
        timeLine?.layer.position = CGPoint(x: self.bounds.width / 2.0, y: timeLineFrame.height / 2.0)
        timeLine?.frame = timeLineFrame
        timeLine?.backgroundColor = UIColor.yellow
        addSubview(timeLine!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: public
    func updateHourTime(hour:Int, animation:Bool = false) {
        if hour >= 24 || hour < 0 {
            return
        }
        calculateClockStatus = .hour
        calculateHourStatus = TCClockHourStatus(rawValue: hour / 12)!
        // 获得 view 需要旋转的角度
        let radius = CGFloat(hour % 12) * 30.0
        self.animation(with: radius * self.perRadius, animation: animation)
        
    }
    
    func updateMintuesTime(minutes:Int, animation:Bool = false) {
        if minutes >= 60 || minutes < 0 {
            return
        }
        calculateClockStatus = .minutes
        // 获得 view 需要旋转的角度
        let radius = CGFloat(minutes) * 6.0
        self.animation(with: radius * self.perRadius, animation: animation)
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
    
    // MARK:private
    func setupAction() {
        // 当用户转动钟面的时候就可以调整指针的位置
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(moveAnimation(gesture:)))
        self.isUserInteractionEnabled = true;
        self.addGestureRecognizer(pan)
    }
    
    @objc func moveAnimation(gesture:UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        let centerPoint = CGPoint.init(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let offset:CGPoint = CGPoint(x:CGFloat(point.x - centerPoint.x), y:CGFloat(point.y - centerPoint.y))

        var radius:CGFloat = 0.0;
        // 右下角
        if offset.x > 0 && offset.y >= 0 {
            radius = atan(offset.y / offset.x) / perRadius
        }

        // 左下角
        if offset.x <= 0 && offset.y > 0 {
            radius = 90 + atan(abs(offset.x) / offset.y) / perRadius
        }

        // 左上角
        if offset.x <= 0 && offset.y < 0 {
            radius = 180 + atan(abs(offset.y) / abs(offset.x)) / perRadius
        }

        // 右上角
        if offset.x > 0 && offset.y <= 0 {
            radius = 270 + atan(offset.x / abs(offset.y)) / perRadius
        }

        print(radius)
    }
    
    @objc func click(button:UIButton) {
        if clickHourClosur != nil && status == .hour {
            let hour = self.hourStatus == .AM ? button.tag : 12 + button.tag
            clickHourClosur!(hour)
            updateHourTime(hour: hour, animation: true)
            self.select(buttonIndex: button.tag)
        }
        
        // 暂时着这样，之后再精确到分钟
        if clickMinuteClosur != nil && status == .minutes {
            let minutes = button.tag * 5
            clickMinuteClosur!(minutes)
            updateMintuesTime(minutes: minutes, animation: true)
            self.select(buttonIndex: button.tag)
        }
    }
    
    func animation(with radius:CGFloat, animation:Bool = false) {
        if animation {
            UIView.animate(withDuration: 0.3, animations: {
                self.timeLine?.transform = CGAffineTransform(rotationAngle: radius)
            })
        } else {
            self.timeLine?.transform = CGAffineTransform(rotationAngle: radius)
        }
    }
}

