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
    let cancelButton:UIButton = UIButton.init(type: .custom)
    let finishedButton:UIButton = UIButton.init(type: .custom)
    
    init(with status:TCClockPickerStatus) {
        self.status = status
        self.clock = TCClockView.init(with: status)
        super.init(frame: .zero)
        
        cancelButton.backgroundColor = UIColor.red
        finishedButton.backgroundColor = UIColor.black
        
        addSubview(clock)
        addSubview(cancelButton)
        addSubview(finishedButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let clockOffset:CGFloat = 30
        let clockWH:CGFloat = self.bounds.width - clockOffset * 2
        self.clock.frame = CGRect(x: clockOffset, y: clockOffset * 2, width: clockWH, height: clockWH)
        
        let buttonWH:CGFloat = 30
        cancelButton.frame = CGRect(x: marginOffset, y: marginOffset, width: buttonWH, height: buttonWH)
        finishedButton.frame = CGRect(x: self.bounds.width - buttonWH - marginOffset, y: marginOffset, width: buttonWH, height: buttonWH)
    }

}
