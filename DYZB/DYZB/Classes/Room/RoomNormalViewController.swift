//
//  RoomNormalViewController.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/22.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
