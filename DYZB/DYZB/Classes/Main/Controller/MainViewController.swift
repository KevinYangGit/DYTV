//
//  MainViewController.swift
//  DYZB
//
//  Created by 杨琦 on 2016/10/13.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
    }
    
    fileprivate func addChildVC(_ storyName : String) {
        
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
