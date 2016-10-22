//
//  RecommendViewController.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/15.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

private let kCycleViewH = KScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    //懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: KScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: KScreenW, height: kGameViewH);
        return gameView
    }()
}

extension RecommendViewController {

    override func setupUI() {
        super.setupUI()
    
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController {

    override func loadData() {
        baseVM = recommendVM
        //请求推荐数据
        recommendVM.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            self.loadDataFinished()
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
