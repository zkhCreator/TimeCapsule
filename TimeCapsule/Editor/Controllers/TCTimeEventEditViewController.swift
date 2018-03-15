//
//  TCTimeEventEditViewController.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeEventEditViewController: TCBasicViewController {

    var eventView = TCEventView.init(frame: CGRect.zero)
    let eventModel:TCEventShowModel
    let contentView = UITableView.init(frame: CGRect.zero, style: .plain)
    let calenderPickerView:TCCalenderPickerView
    let clockPickerView:TCClockPickerView
    
    init(with data:TCEventModel = TCEventModel()) {
        eventModel = TCEventShowModel.init(with: data)
        calenderPickerView = TCCalenderPickerView.init(with: eventModel)
        clockPickerView = TCClockPickerView(with: eventModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.updateDate()
    }
    
    func setupView() {
        view.addSubview(eventView)
        view.addSubview(contentView)
//        view.addSubview(calenderPickerView)
        view.addSubview(clockPickerView)
        
        view.backgroundColor = UIColor.white
        eventView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 170)
        eventView.backgroundColor = UIColor.red
        
        let eventViewOffsetY = eventView.frame.origin.y + eventView.frame.height
        contentView.frame = CGRect(x: 0, y: eventViewOffsetY, width: view.bounds.width, height: view.bounds.height - eventViewOffsetY)
        contentView.backgroundColor = UIColor.green
        
        calenderPickerView.frame = contentView.frame
        clockPickerView.frame = contentView.frame
    }
    
    func updateDate() {
        eventView.updateView(with: eventModel)
    }
}
