//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/22.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {
    
    internal var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

}

