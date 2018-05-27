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
    var headerView:TCTimeListCreateNewItemView? = TCTimeListCreateNewItemView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        listView.delegate = self;
        listView.dataSource = self;
        var listViewFrame = self.view.frame
        listViewFrame.origin.y +=  self.statusBarView.frame.height
        listViewFrame.size.height -= self.statusBarView.frame.height
        listView.frame = listViewFrame
        
        headerView!.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 44)
        
        self.view.addSubview(listView)
        self.listView.addSubview(headerView!)
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
        return UITableViewCell.init();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.headerView?.state = .idle
    }
    
}
