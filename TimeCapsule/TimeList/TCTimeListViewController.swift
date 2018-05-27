//
//  TCTimeListViewController.swift
//  TimeCapsule
//
//  Created by 章凯华 on 01/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListViewController: TCBasicViewController {
    let listView = UITableView.init(frame: CGRect.zero, style: .grouped)
    let createItemCell = TCTimeLIstCreateNewItemCell.init()
    let viewModel = TCTimeListViewModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(listView)
    }
    
    func setListView() {
        listView.delegate = self;
        listView.dataSource = self;
        var listViewFrame = self.view.frame
        listViewFrame.origin.y +=  self.statusBarView.frame.height
        listViewFrame.size.height -= self.statusBarView.frame.height
        listView.frame = listViewFrame
        listView.contentInset = UIEdgeInsetsMake(-(viewModel.safeObject(with: NSIndexPath(row: 0, section: 0))?.height ?? createItemHeight), 0, 0, 0);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        listView.contentOffset = CGPoint(x: 0, y: -(headerView.frame.height));
    }
}


extension TCTimeListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.createItemCell
        }
        return UITableViewCell.init();
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if <#condition#> {
//            <#code#>
//        }
        return 60
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.headerView?.state = .idle
//    }
    
}
