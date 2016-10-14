//
//  PageContentView.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/14.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegete : PageContentViewDelegate?
    
    //懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self as! UICollectionViewDataSource?
        collectionView.delegate = self as! UICollectionViewDelegate?
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs : [UIViewController], parentViewController : UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
