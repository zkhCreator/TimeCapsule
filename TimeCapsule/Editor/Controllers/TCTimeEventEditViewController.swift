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
    let tableview = UITableView.init(frame: CGRect.zero, style: .plain)
    
    init(with data:TCEventModel = TCEventModel()) {
        eventModel = TCEventShowModel.init(with: data)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(eventView)
        eventView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 170)
        eventView.backgroundColor = UIColor.red
        eventView.updateView(with: eventModel)
    }
}
