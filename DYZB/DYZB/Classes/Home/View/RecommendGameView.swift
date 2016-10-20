//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 杨琦 on 2016/10/18.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdageInsetMargin : CGFloat = 10
class RecommendGameView: UIView {

    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //定义数据的属性
    var groups : [BaseGameModel]? {
        didSet {
            //刷新表格
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // 让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdageInsetMargin, bottom: 0, right: kEdageInsetMargin)
    }
}

//快速创建类的方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![(indexPath as NSIndexPath).item]
        
        return cell
        
    }
}

