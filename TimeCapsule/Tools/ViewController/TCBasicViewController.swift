//
//  TCBasicViewController.swift
//  TimeCapsule
//
//  Created by 章凯华 on 10/03/2018.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

class TCBasicViewController: UIViewController {
    let statusBarView:UIView = UIView.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarView.backgroundColor = tcBackgroundColor
        statusBarView.frame = UIApplication.shared.statusBarFrame
        statusBarView.layer.zPosition = 999
        self.view.addSubview(statusBarView);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
