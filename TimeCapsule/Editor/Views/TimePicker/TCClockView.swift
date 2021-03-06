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
    var selectedIndex = 0;
    var clearning = false
    var selecting = false


    // 所有的按钮
    var timeButtonArray = [UIButton]()
    var minuteButtonArray = [UIButton]()
    
    // 用于读写当前的钟面是小时还是分钟
    var calculateClockStatus:TCClockPickerState {
        set {
            if self.state == newValue {
                return
            }
            
            self.state = newValue
//            for (index, button) in self.timeButtonArray.enumerated() {
//                button.setTitle(status == .hour ? self.hourStatus == .AM ? "\(index)" : "\((index + 12)) " : "\((index) * 5)", for: .normal)
//            }
            
            let hiddenButton = newValue == .minutes ? false : true
            for button in minuteButtonArray {
                button.isHidden = hiddenButton
            }
            
        } get {
            return self.state
        }
    }
    private var state:TCClockPickerState = .hour
    
    // 用于读写当前的钟面时候 AM 还是 PM
    var calculateHourStatus:TCClockHourStatus {
        set {
            if state != .hour || self.hourStatus == newValue {
                return
            }
            self.hourStatus = newValue
            
//            for (index, button) in self.timeButtonArray.enumerated() {
//                button.setTitle(self.hourStatus == .AM ? "\(index)" : "\(index + 12) ", for: .normal)
//            }
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
    
    var currentHourRadius:CGFloat = 0;  // 弧度值
    var currentMintuesRadius:CGFloat = 0;
    
    // MARK:Static
    let WH:CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRoundClockView()
        setupClockFace()
        setupAction()
    }
    
    func setupRoundClockView() {
        let backgroundView = UIView.init(frame: self.bounds)
        backgroundView.layer.cornerRadius = self.bounds.size.width / 2.0
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.setupShadow(blur:6)
        self.addSubview(backgroundView)
    }
    
    func setupClockFace() {
        for index in 0 ..< 60 {
            let button = createMinuteButton(with: index)
            minuteButtonArray.append(button)
            addSubview(button)
        }
        
        
        for index in 0 ..< 12 {
            let button = createHourButton(with: index)
            timeButtonArray.append(button)
            addSubview(button)
        }
    }
    
    func createHourButton(with index:Int) -> UIButton {
        let size = CGSize.init(width: WH, height: WH)
        let radius:CGFloat = (self.bounds.width - size.width - 30.0) / 2
        let button = UIButton.init(type: .custom)
        button.titleLabel?.textAlignment = .center
        button.layer.setupShadow(blur:4)
        button.tag = index
        button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = size.width / 2.0
        
        let correctRadius:CGFloat = perRadius * CGFloat((-90 + index * 30))
        let offsetY = sin(correctRadius) * radius
        let offsetX = cos(correctRadius) * radius
        let originX = self.bounds.width / 2 - size.width / 2 + offsetX
        let originY = self.bounds.height / 2 - size.width / 2 + offsetY
        button.frame = CGRect(origin: CGPoint(x:originX, y:originY), size: size)
//        button.setTitle(status == .hour ? "\(index)" : "\((index) * 5)", for: .normal)
        
        return button
    }
    
    func createMinuteButton(with index:Int) -> UIButton {
        let size = CGSize.init(width: WH / 8, height: WH / 8)
        let radius:CGFloat = (self.bounds.width - size.width) / 2
        let button = UIButton.init(type: .custom)
        button.titleLabel?.textAlignment = .center
        button.tag = index
        button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        button.layer.cornerRadius = size.width / 2.0
        button.isHidden = true
        
        let correctRadius:CGFloat = perRadius * CGFloat((-90 + index * 6))
        let offsetY = sin(correctRadius) * radius
        let offsetX = cos(correctRadius) * radius
        let originX = self.bounds.width / 2 - size.width / 2 + offsetX
        let originY = self.bounds.height / 2 - size.width / 2 + offsetY
        button.frame = CGRect(origin: CGPoint(x:originX, y:originY), size: size)

        return button
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:private
    func setupAction() {
        // 当用户转动钟面的时候就可以调整指针的位置
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(moveAnimation(gesture:)))
        self.isUserInteractionEnabled = true;
        self.addGestureRecognizer(pan)
    }
    
    /// 滑动的逻辑处理
    ///
    /// - Parameter gesture: 滑动手势
    @objc func moveAnimation(gesture:UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        let centerPoint = CGPoint.init(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let offset:CGPoint = CGPoint(x:CGFloat(point.x - centerPoint.x), y:CGFloat(point.y - centerPoint.y))

        let radius = self.getCorrectRadis(offset: offset)
        
        // 获得对应选中的为第 x 个按钮
        if state == .hour {
            let hour = lroundf(Float(self.currentHourRadius / 30.0)) % 12
            if hour == self.selectedIndex {
                return
            }
        }
        
        if gesture.state != .ended || gesture.state == .cancelled {
            
        } else {
            let correctTime = convertToShowTime(with: radius, clockStatus: self.state)
            updateTime(date: correctTime, animation: true)
        }
        
        if self.state == .hour {
            self.currentHourRadius = radius
            let correctHour = convertToShowTime(with: radius, clockStatus: .hour)
            if clickHourClosur != nil {
                clickHourClosur!(correctHour)
            }
            selectButton(at: correctHour % 12)
        } else {
            self.currentMintuesRadius = radius
            let correctMinute = convertToShowTime(with: radius, clockStatus: .minutes)
            if clickMinuteClosur != nil {
                clickMinuteClosur!(correctMinute)
            }
            
            self.selectButton(at: correctMinute)
        }
    }
    
    /// 用于内部调用的点击事件
    ///
    /// - Parameter button: 点击的按钮
    @objc func click(button:UIButton) {
        if clickHourClosur != nil && state == .hour {
            let hour = self.hourStatus == .AM ? button.tag : 12 + button.tag
            clickHourClosur!(hour)
            updateHourTime(hour: hour, animation: true)
            self.selectButton(at: button.tag)
        }
        
        // 暂时着这样，之后再精确到分钟
        if clickMinuteClosur != nil && state == .minutes {
            let minutes = button.tag * 5
            clickMinuteClosur!(minutes)
            updateMintuesTime(minutes: minutes, animation: true)
            self.selectButton(at: button.tag)
        }
    }
}

// MARK: Public
extension TCClockView {
    /// 清除选中的状态
    func clear() {
        selectButton?.isSelected = false
        clearning = true
        UIView.animate(withDuration: 0.3, animations: {
            self.selectButton?.backgroundColor = UIColor.white
        }) { (finished) in
            if finished {
                self.clearning = false
            }
        }
    }
    
    func selectButton(at index:NSInteger) {
        selectedIndex = index;
        self.clear()
        let needSelectButton = self.state == .hour ? timeButtonArray[safe:index] : minuteButtonArray[safe:index]
        needSelectButton?.isSelected = true
        self.selectButton = needSelectButton
        selecting = true
        UIView.animate(withDuration: 0.3, animations: {
            self.selectButton?.backgroundColor = deepColor
        }) { (finished) in
            if finished {
                self.selecting = false
            }
        }
    }
}

// MARK: Private
extension TCClockView {
    // MARK: Logic
    /// 将手势获得的位置偏移量转换成正确的旋转角度
    ///
    /// - Parameter offset: 手指相对中心点的偏移量
    /// - Returns: 获得的旋转角度
    func getCorrectRadis(offset:CGPoint) -> CGFloat {
        var radius:CGFloat = 0.0;
        // 右下角
        if offset.x > 0 && offset.y >= 0 {
            radius = 90 + atan(offset.y / offset.x) / perRadius
        }
        
        // 左下角
        if offset.x <= 0 && offset.y > 0 {
            radius = 180 + atan(abs(offset.x) / offset.y) / perRadius
        }
        
        // 左上角
        if offset.x <= 0 && offset.y < 0 {
            radius = 270 + atan(abs(offset.y) / abs(offset.x)) / perRadius
        }
        
        // 右上角
        if offset.x > 0 && offset.y <= 0 {
            radius = atan(offset.x / abs(offset.y)) / perRadius
        }
        
        return radius
    }
    
    /// 将角度转换成对应的用于显示的数值
    ///
    /// - Parameters:
    ///   - currentRadius: 旋转的角度
    ///   - clockStatus: 当前是时针还是分针
    /// - Returns: 获得的时间，分别对应小时和分钟
    func convertToShowTime(with currentRadius:CGFloat, clockStatus:TCClockPickerState) -> Int {
        if state == .hour {
            let hour = lroundf(Float(self.currentHourRadius / 30.0)) % 12
            let correctHour = hourStatus == .AM ? hour : hour + 12
            return correctHour
        } else {
            let minute = lroundf(Float(self.currentMintuesRadius / 6.0))
            return minute % 60
        }
    }
    
    // MARK: public
    
    func updateTime(date:Int, animation:Bool = false) {
        self.state == .hour ? updateHourTime(hour: date, animation: animation) : updateMintuesTime(minutes: date, animation: animation)
    }
    
    /// 通过小时调整 UI，到对应的小时上面
    ///
    /// - Parameters:
    ///   - hour: 小时 24小时制
    ///   - animation: 是否需要进行动画
    func updateHourTime(hour:Int, animation:Bool = false) {
        if hour >= 24 || hour < 0 {
            return
        }
        calculateClockStatus = .hour
        calculateHourStatus = TCClockHourStatus(rawValue: hour / 12)!
        // 获得 view 需要旋转的角度
        let radius = CGFloat(hour % 12) * 30.0
        self.currentHourRadius = radius
    }
    
    /// 通过小时调整 UI，到对应的分钟上面
    ///
    /// - Parameters:
    ///   - hour: 小时 24小时制
    ///   - animation: 是否需要进行动画
    func updateMintuesTime(minutes:Int, animation:Bool = false) {
        if minutes >= 60 || minutes < 0 {
            return
        }
        calculateClockStatus = .minutes
        // 获得 view 需要旋转的角度
        let radius = CGFloat(minutes) * 6.0
        self.currentMintuesRadius = radius
    }
}

