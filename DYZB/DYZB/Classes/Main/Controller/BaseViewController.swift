//
//  BaseViewController.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/20.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //定义内容view
    var contentView : UIView?
    //动画
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BaseViewController {

    func setupUI() {
        //隐藏内容的view
        contentView?.isHidden = true
        
        //添加动画
        view.addSubview(animImageView)
        
        //执行动画
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
