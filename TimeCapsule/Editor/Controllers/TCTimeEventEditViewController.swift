//
//  TCTimeEventEditViewController.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeEventEditViewController: TCBasicViewController {

    // MARK: Data
    let eventModel:TCEventShowModel
    
    // View: View
    var eventView:TCEventView?
    var contentView:UITableView?
    var calenderPickerView:TCCalenderPickerView?
    var clockPickerView:TCClockPickerView?
    
    init(with data:TCEventModel = TCEventModel()) {
        eventModel = TCEventShowModel.init(with: data)
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
        view.backgroundColor = UIColor.white
        eventView = TCEventView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 170))
        eventView!.backgroundColor = UIColor.red
        
        let eventViewOffsetY = eventView!.frame.origin.y + eventView!.frame.height
        contentView = UITableView(frame: CGRect(x: 0, y: eventViewOffsetY, width: view.bounds.width, height: view.bounds.height - eventViewOffsetY), style: .plain)
        contentView?.backgroundColor = UIColor.green
        
        calenderPickerView = TCCalenderPickerView.init(frame: contentView!.frame)
        clockPickerView = TCClockPickerView.init(frame: contentView!.frame)
        
        view.addSubview(eventView!)
        view.addSubview(contentView!)
        view.addSubview(calenderPickerView!)
//        view.addSubview(clockPickerView!)
    }
    
    func updateDate() {
        eventView?.updateView(with: eventModel)
        calenderPickerView?.update(with: eventModel)
        clockPickerView?.updateTime(time: eventModel)
    }
}
