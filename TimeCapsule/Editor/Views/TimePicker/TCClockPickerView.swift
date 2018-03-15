//
//  TCClockPickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 14/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCClockPickerView: UIView {
    
    let status:TCClockPickerStatus
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
    
    init(with status:TCClockPickerStatus, hourStatus:TCClockHourStatus = .AM) {
        self.status = status
        self.clock = TCClockView.init(with: status, hourStatus: hourStatus)
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
    
    @objc func clickHourButton(button:UIButton) {
        let hourStatus:TCClockHourStatus = TCClockHourStatus(rawValue: button.tag)!
        self.clock.calculateHourStatus = hourStatus
    }
    
    @objc func clickStatusButton(button:UIButton) {
        let status:TCClockPickerStatus = TCClockPickerStatus(rawValue: button.tag)!
        self.clock.calculateClockStatus = status
    }
    
}
