//
//  TCEventView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit
import SnapKit

class TCEventView: UIView {
    
    let cancelButton = UIButton.init(image: UIImage.init(named: "closeButton")!)
    let finishButton = UIButton.init(image: UIImage.init(named: "finishButton")!)
    
    let yearButton = UIButton.init(type: .custom)
    let monthButton = UIButton.init(type: .custom)
    let dayButton = UIButton.init(type: .custom)
    let weekButton = UIButton.init(type: .custom)
    let timeButton = UIButton.init(type: .custom)
    let summaryTextField = UITextField.init()
    let notiButton = UIButton.init(type: .custom)
    let statusButton = UIButton.init(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = CAGradientLayer.init(size: frame.size)
        self.layer.addSublayer(gradientLayer)
        
        addSubview(cancelButton)
        addSubview(finishButton)
        
        addSubview(yearButton)
        addSubview(monthButton)
        addSubview(dayButton)
        addSubview(weekButton)
        addSubview(timeButton)
        addSubview(summaryTextField)
        addSubview(notiButton)
        addSubview(statusButton)
        
        setupAutoLayout()
        setupUI()
    }
    
    func setupAutoLayout() {
        cancelButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(marginOffset)
            make.width.height.equalTo(28.0)
        }
        
        finishButton.snp.makeConstraints { (make) in
            make.width.height.top.equalTo(cancelButton)
            make.right.equalTo(-marginOffset)
        }
        
        yearButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(marginOffset)
            make.top.equalTo(cancelButton.snp.bottom).offset(5)
            make.height.equalTo(24)
        }
        
        monthButton.snp.makeConstraints { (make) in
            make.left.equalTo(yearButton)
            make.top.equalTo(yearButton.snp.bottom)
            make.height.equalTo(48)
        }
        
        dayButton.snp.makeConstraints { (make) in
            make.left.equalTo(monthButton.snp.right).offset(4)
            make.top.equalTo(monthButton)
            make.height.equalTo(48)
        }
        
        weekButton.snp.makeConstraints { (make) in
            make.left.equalTo(dayButton.snp.right).offset(8)
            make.top.equalTo(dayButton)
            make.height.equalTo(48)
        }
        
        timeButton.snp.makeConstraints { (make) in
            make.left.equalTo(monthButton)
            make.top.equalTo(monthButton.snp.bottom)
            make.height.equalTo(33)
        }
        
        summaryTextField.snp.makeConstraints { (make) in
            make.left.equalTo(timeButton)
            make.right.equalTo(self).offset(-marginOffset)
            make.height.equalTo(24.0)
            make.top.equalTo(timeButton.snp.bottom)
        }
        
//        statusButton.snp.makeConstraints { (make) in
//            make.right.equalTo(self).offset(-marginOffset)
//            make.top.equalTo(self).offset(marginOffset)
//            make.width.height.equalTo(28)
//        }
//
//        notiButton.snp.makeConstraints { (make) in
//            make.right.equalTo(statusButton.snp.left).offset(-marginOffset)
//            make.top.equalTo(self).offset(marginOffset)
//            make.width.height.equalTo(28)
//        }
    }
    
    func setupUI() {
        
        yearButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        monthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        dayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        weekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        timeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        notiButton.backgroundColor = UIColor.yellow
        statusButton.backgroundColor = UIColor.black
        
        let attributeString = NSMutableAttributedString.init(string: "将要发生写什么事情呢？", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.45), NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17.0)])
        summaryTextField.attributedPlaceholder = attributeString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model:TCEventShowModel) {
        yearButton.setTitle(model.yearString, for: .normal)
        monthButton.setTitle(model.monthString, for: .normal)
        weekButton.setTitle(model.weekString, for: .normal)
        dayButton.setTitle(model.dayString, for: .normal)
        timeButton.setTitle(model.timeString, for: .normal)
        summaryTextField.text = model.summaryString
    }
}
