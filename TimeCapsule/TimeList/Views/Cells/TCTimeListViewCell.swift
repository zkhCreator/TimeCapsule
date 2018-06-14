//
//  TCTimeListViewCellTableViewCell.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/5/20.
//  Copyright © 2018年 zkhCreator. All rights reserved.
//

import UIKit
import MCSwipeTableViewCell

class TCTimeListViewCell:TCBasicListTableViewCell {
    
    let marginX:CGFloat = 10
    let marginY:CGFloat = 8
    let gradientLayer = CAGradientLayer.init(size: CGSize.zero)
    
    let containerView:UIView = {
        let containerView = UIView.init()
        return containerView
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "12:00"
        return label
    }()
    
    let thingLabel:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "这里是将要做的事情"
        return label
    }()
    
    let tagContainer = TCTagListContainerView.init(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = tcBackgroundColor
        self.setupView()
        self.addContainerViewGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(containerView)
        self.gradientLayer.cornerRadius = 8
        self.gradientLayer.shadowColor = UIColor.black.cgColor
        self.gradientLayer.shadowOpacity = 0.3
        self.gradientLayer.shadowRadius = 4
        self.gradientLayer.shadowOffset = CGSize.init(width: 0, height: 2)
        containerView.layer.addSublayer(self.gradientLayer)
        
        self.containerView.addSubview(timeLabel)
        self.containerView.addSubview(thingLabel)
        self.containerView.addSubview(tagContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = CGSize(width: self.contentView.bounds.width - 20 * 2, height: self.contentView.bounds.height - 5 * 2)
        let origin = CGPoint.init(x: (self.contentView.bounds.width - size.width) / 2, y: (self.contentView.bounds.height - size.height) / 2)
        self.containerView.frame = CGRect.init(origin: origin, size: size)
        
        timeLabel.sizeToFit()
        let timeOrigin = CGPoint.init(x: marginX, y: marginY)
        var timeLabelSize = timeLabel.frame.size
        if (timeLabel.text ?? "").isEmpty {
            timeLabelSize = CGSize.zero
        }
        timeLabel.frame = CGRect.init(origin: timeOrigin, size: timeLabelSize)
        
        let thingsFrame = CGRect.init(x: timeOrigin.x, y: timeLabel.frame.maxY, width: self.containerView.frame.width - 10 * 2, height: 24)
        thingLabel.frame = thingsFrame
        
        tagContainer.sizeToFit()
        let containerRect = CGRect.init(x: self.containerView.frame.width - marginX - tagContainer.frame.width,
                                        y: marginY,
                                        width: self.tagContainer.frame.width,
                                        height: self.tagContainer.frame.height)
        tagContainer.frame = containerRect
        
        
        self.gradientLayer.frame = self.containerView.bounds
    }
}


// MARK: - UserAction 
extension TCTimeListViewCell{
    //
    func addContainerViewGesture() {
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        self.setSwipeGestureWith(view, color: tcBackgroundColor, mode: .switch, state: .state1, completionBlock: nil);
//        let pan = Pain
//        self.setupView()
    }
    
    @objc
    func moveContainer(with gesture:UIPanGestureRecognizer) {
        print(gesture)
    }
}
