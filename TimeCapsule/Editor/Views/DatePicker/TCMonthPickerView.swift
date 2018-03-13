//
//  TCMonthPickerView.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCMonthPickerView: UIView {

    let leftButton = UIButton.init(type: .custom)
    let rightButton = UIButton.init(type: .custom)
    
    var currentLabel = UILabel.init()
    var nextLabel = UILabel.init()
    
    var updateMonthClosuer:((TCMonthClickStatus)->(TCEventShowModel))?
    
    var needsUpDateCurrentLabelFrame:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(currentLabel)
        addSubview(nextLabel)
        
        currentLabel.textAlignment = .center
        nextLabel.textAlignment = .center
        
        leftButton.backgroundColor = UIColor.red
        rightButton.backgroundColor = UIColor.red
        currentLabel.backgroundColor = UIColor.yellow
        nextLabel.backgroundColor = UIColor.yellow
        
        leftButton.addTarget(self, action: #selector(clickPreviousButton), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(clickNextButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrame()
    }
    
    func setupFrame() {
        setupButton()
        if !needsUpDateCurrentLabelFrame {
            setupCurrentLabelFrame()
            needsUpDateCurrentLabelFrame = true
        }
    }
    
    func setupButton() {
        let height = self.bounds.height
        let btnHW:CGFloat = 20
        leftButton.frame = CGRect(x: 16,
                                  y:(height - btnHW) / 2 ,
                                  width: btnHW, height: btnHW);
        
        rightButton.frame = CGRect(x: self.bounds.width - 16 - rightButton.frame.size.width,
                                   y: leftButton.frame.origin.y,
                                   width: btnHW,
                                   height: btnHW)
    }
    
    // TODO: add button && label frame to layoutSubview && set key to switch update or animation
    func setupCurrentLabelFrame() {
        currentLabel.sizeToFit()
        currentLabel.frame = createFrame(with: .middle, view: currentLabel);
    }
    
    func updateCurrentLabel(model:TCEventShowModel) {
        currentLabel.text = generateTitleString(showModel: model)
        needsUpDateCurrentLabelFrame = false
        setupCurrentLabelFrame()
    }
    
    @objc func clickPreviousButton() {
        self.clickButton(with: .previous)
    }
    
    @objc func clickNextButton() {
        self.clickButton(with: .next)
    }
    
    func clickButton(with status:TCMonthClickStatus) {
        guard self.updateMonthClosuer != nil else {
            return ;
        }
        let nextShowModel:TCEventShowModel = self.updateMonthClosuer!(status)
        let nextTitle = generateTitleString(showModel: nextShowModel)
        
        nextLabel.text = nextTitle
        nextLabel.sizeToFit()
        self.startAnimate(clickStatus: status)
    }
    
    // MARK:Animation
    func startAnimate(clickStatus:TCMonthClickStatus) {
        let currentLabelMissFrame = clickStatus == .next ? createFrame(with: .left, view: currentLabel) : createFrame(with: .right, view: currentLabel)
        let nextLabelFrame = clickStatus == .next ? createFrame(with: .right, view: nextLabel) : createFrame(with: .left, view: nextLabel)
        let nextLabelMissFrame = createFrame(with: .middle, view: nextLabel)
        self.nextLabel.frame = nextLabelFrame
        
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        
        self.currentLabel.alpha = 1
        self.nextLabel.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.currentLabel.frame = currentLabelMissFrame
            self.nextLabel.frame = nextLabelMissFrame
            self.currentLabel.alpha = 0
            self.nextLabel.alpha = 1
        }) { (finished) in
            if finished {
                let tempLabel = self.currentLabel;
                self.currentLabel = self.nextLabel
                self.nextLabel = tempLabel
                
                self.leftButton.isEnabled = true
                self.rightButton.isEnabled = true
            }
        }
    }
    
    // MARK: private
    func generateTitleString(showModel:TCEventShowModel) -> String {
        return showModel.monthFullString + " " + showModel.yearString
    }
    
    func createNextLabel(with status:TCMonthClickStatus, title:String) -> UILabel {
        let tempLabel = UILabel.init(frame: .zero)
        tempLabel.textColor = UIColor.black
        tempLabel.backgroundColor = UIColor.yellow
        tempLabel.text = title
        tempLabel.sizeToFit()
        if status == .next {
            tempLabel.frame = CGRect(x: self.rightButton.frame.origin.x - tempLabel.frame.size.width,
                                     y: (self.bounds.height - tempLabel.frame.size.height) / 2,
                                     width: tempLabel.frame.size.width,
                                     height: tempLabel.frame.size.height)
        } else {
            tempLabel.frame = CGRect(x: self.leftButton.frame.origin.x - self.leftButton.frame.size.width,
                                     y: (self.bounds.height - tempLabel.frame.size.height) / 2,
                                     width: tempLabel.frame.size.width,
                                     height: tempLabel.frame.size.height)
        }
        
        return tempLabel
    }
    
    func createFrame(with position:TCCustomViewPosition, view:UIView) -> CGRect{
        var frame = CGRect.zero
        
        let height = self.bounds.height
        let width = self.bounds.width
        
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        switch position {
        case .left:
            frame = CGRect(x: self.leftButton.frame.origin.x + self.leftButton.frame.size.width,
                           y: (height - viewHeight) / 2,
                           width: viewWidth,
                           height: viewHeight)
        case .middle:
            frame = CGRect.init(x: (width - viewWidth) / 2,
                                y: (height - viewHeight) / 2,
                                width: viewWidth,
                                height: viewHeight)
        case .right:
            frame = CGRect(x: self.rightButton.frame.origin.x - viewWidth,
                           y: (height - viewHeight) / 2,
                           width: viewWidth,
                           height: viewHeight)
        }
        return frame
    }
    

}
