//
//  TCTimeListViewController.swift
//  TimeCapsule
//
//  Created by 章凯华 on 01/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCTimeListViewController: TCBasicViewController {
    let listView = UITableView.init(frame: CGRect.zero, style: .plain)
    let createItemCell = TCTimeListCreateNewItemCell.init()
    let viewModel = TCTimeListViewModels()
    
    let stateManager:TCTimeListStateManager
    let maskView = TCTimeListMaskView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        listView.contentInset = UIEdgeInsetsMake(-(viewModel.safeObject(with: IndexPath.init(row: 0, section: 0))?.height ?? createItemHeight), 0, 0, 0);
        listView.register(TCTimeListViewCellTableViewCell.self, forCellReuseIdentifier: String(describing: TCTimeListViewCellTableViewCell.self))
        self.stateManager = TCTimeListStateManager.init(with: self.listView)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = tcBackgroundColor
        self.setListView()
        self.setMaskView()
        self.bindState()
    }
    
    func setListView() {
        listView.delegate = self;
        listView.dataSource = self;
        var listViewFrame = self.view.frame
        listViewFrame.origin.y +=  self.statusBarView.frame.height
        listViewFrame.size.height -= self.statusBarView.frame.height
        listView.estimatedRowHeight = 70
        listView.frame = listViewFrame
        listView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0.0, height: CGFloat.leastNormalMagnitude)))
        listView.backgroundColor = tcBackgroundColor
        listView.separatorStyle = .none
        listView.separatorColor = UIColor.clear
        listView.showsVerticalScrollIndicator = false
        listView.showsHorizontalScrollIndicator = false
        self.view.addSubview(listView)
        
        self.createItemCell.selectionStyle = .none
    }
    
    func setMaskView() {
        maskView.frame = self.listView.frame
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickMaskView))
        maskView.addGestureRecognizer(tap)
        self.view.addSubview(maskView)
    }
    
    func bindState() {
        self.stateManager.showCreateItemClosure = {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.maskView.alpha = 1
                })
            })
        }
    }
}


extension TCTimeListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.createItemCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TCTimeListViewCellTableViewCell.self))!;
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let obj = viewModel.safeObject(with: indexPath) else {
            return 0
        }
        
        return obj.height
    }
}

// MARK: - All Click Action
extension TCTimeListViewController {
    @objc func clickMaskView() {
        self.listView.isScrollEnabled = true
        self.createItemCell.reset()
        UIView.animate(withDuration: 0.3, animations: {
            self.listView.setContentOffset(CGPoint.init(x: 0, y: createItemHeight), animated: false)
            self.maskView.alpha = 0
        })
    }
}
