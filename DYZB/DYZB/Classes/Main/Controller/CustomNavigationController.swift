//
//  CustomNavigationController.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/22.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        guard let gesView = systemGes.view else { return }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
