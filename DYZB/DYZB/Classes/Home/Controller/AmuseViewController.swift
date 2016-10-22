//
//  AmuseViewController.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/22.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension AmuseViewController {
    override func loadData() {
        baseVM = amuseVM
        
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            
            self.loadDataFinished()
        }
    }
}
