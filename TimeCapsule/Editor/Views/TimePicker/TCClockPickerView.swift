//
//  TCClockPickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 14/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCClockPickerView: UIView {
    
    var currentTime:TCEventShowModel
    let clock:TCClockView
    let hourButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        button.setTitle("12", for: .normal)
        button.tag = TCClockPickerStatus.hour.rawValue
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let minuteButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("00", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        button.tag = TCClockPickerStatus.minutes.rawValue
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.text = ":"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.sizeToFit()
        return label
    }()
    let cancelButton:UIButton = UIButton.init(type: .custom)
    let finishedButton:UIButton = UIButton.init(type: .custom)
    
    let AMButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("AM", for: .normal)
        button.tag = TCClockHourStatus.AM.rawValue
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        return button
    }()
    let PMButton:UIButton =  {
        let button = UIButton.init(type: .custom)
        button.setTitle("PM", for: .normal)
        button.tag = TCClockHourStatus.PM.rawValue
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        return button
    }()
    
    // DATA
    var selectedHour:Int
    var selectedMinute:Int
    
    init(with showModel:TCEventShowModel) {
        self.currentTime = showModel
        clock = TCClockView.init(hourStatus: showModel.manager.hour >= 12 ? .AM : .PM)
        selectedHour = 0
        selectedMinute = 0
        super.init(frame: .zero)
        
        cancelButton.backgroundColor = UIColor.red
        finishedButton.backgroundColor = UIColor.black
        
        addSubview(clock)
        addSubview(cancelButton)
        addSubview(finishedButton)
        addSubview(AMButton)
        addSubview(PMButton)
        addSubview(timeLabel)
        addSubview(hourButton)
        addSubview(minuteButton)
        
        hourButton.addTarget(self, action: #selector(clickStatusButton(button:)), for: .touchUpInside)
        minuteButton.addTarget(self, action: #selector(clickStatusButton(button:)), for: .touchUpInside)
        
        AMButton.addTarget(self, action: #selector(clickHourButton(button:)), for: .touchUpInside)
        PMButton.addTarget(self, action: #selector(clickHourButton(button:)), for: .touchUpInside)
        
        clock.clickMinuteClosur = {(minute:Int) in
            let timeManager = self.currentTime.manager
            self.currentTime.manager.date = Date.customDate(year: timeManager.year, month: timeManager.month.rawValue, day: timeManager.day, hour: timeManager.hour, minute: minute, timeZone: timeManager.comp.timeZone!)
            let minuteString = (minute.toString().count == 1 ? "0" : "") + minute.toString()
            self.minuteButton.setTitle("\(minuteString)", for: .normal)
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        
        clock.clickHourClosur = {(hour:Int) in
            var timeManager = self.currentTime.manager
            self.currentTime.manager.date = Date.customDate(year: timeManager.year, month: timeManager.month.rawValue, day: 
                timeManager.day, hour: hour, minute: timeManager.minute, timeZone: timeManager.comp.timeZone!)
            let hourString = (hour.toString().count == 1 ? "0" : "") + hour.toString()
            self.hourButton.setTitle(hourString, for: .normal)
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWH:CGFloat = 44
        cancelButton.frame = CGRect(x: marginOffset, y: marginOffset, width: buttonWH, height: buttonWH)
        finishedButton.frame = CGRect(x: self.bounds.width - buttonWH - marginOffset, y: marginOffset, width: buttonWH, height: buttonWH)
        
        timeLabel.frame = CGRect.init(x: (self.bounds.size.width - timeLabel.frame.width) / 2.0,
                                      y: marginOffset,
                                      width: timeLabel.frame.width,
                                      height: timeLabel.frame.height)
        hourButton.sizeToFit()
        hourButton.frame = CGRect.init(x: timeLabel.frame.minX - hourButton.frame.width,
                                       y: timeLabel.frame.minY,
                                       width: hourButton.frame.width,
                                       height: timeLabel.frame.height)
        minuteButton.sizeToFit()
        minuteButton.frame = CGRect.init(x: timeLabel.frame.minX + timeLabel.frame.width,
                                         y: timeLabel.frame.minY,
                                         width: minuteButton.frame.width,
                                         height: timeLabel.frame.height)
        
        AMButton.frame = CGRect.init(x: self.bounds.size.width / 2 - AMButton.frame.width - 16,
                                     y: timeLabel.frame.origin.y + timeLabel.frame.size.height,
                                     width: AMButton.frame.size.width,
                                     height: AMButton.frame.size.height)
        
        PMButton.frame = CGRect.init(x: self.bounds.size.width / 2 + 16,
                                     y: timeLabel.frame.origin.y + timeLabel.frame.size.height,
                                     width: PMButton.frame.size.width,
                                     height: PMButton.frame.size.height)
        
        let clockOffset:CGFloat = 30
        let clockWH:CGFloat = self.bounds.width - clockOffset * 2
        self.clock.frame = CGRect(x: clockOffset, y: PMButton.frame.maxY, width: clockWH, height: clockWH)
    }
    
    // AM && PM 切换
    @objc func clickHourButton(button:UIButton) {
        self.clock.clear()
        self.clock.calculateClockStatus = .hour
        self.clock.calculateHourStatus = TCClockHourStatus(rawValue: button.tag)!
        
        if self.clock.calculateHourStatus == .AM && self.currentTime.manager.hour < 12 {
            self.clock.select(buttonIndex: self.currentTime.manager.hour)
        }
        
        if self.clock.calculateHourStatus == .PM && self.currentTime.manager.hour > 12 {
            self.clock.select(buttonIndex: self.currentTime.manager.hour - 12)
        }
    }
    
    // 时分切换
    @objc func clickStatusButton(button:UIButton) {
        self.clock.clear()
        let status = TCClockPickerStatus(rawValue: button.tag)!
        self.clock.calculateClockStatus = status
        if status == .hour {
            self.clock.calculateHourStatus = self.currentTime.manager.hour > 12 ? .PM : .AM
            self.clock.select(buttonIndex: self.currentTime.manager.hour > 12 ? self.currentTime.manager.hour - 12 : self.currentTime.manager.hour)
        } else {
            self.clock.select(buttonIndex: Int(self.currentTime.manager.minute / 5))

        }
        
    }
}
