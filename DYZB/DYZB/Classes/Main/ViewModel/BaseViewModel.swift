//
//  BaseViewModel.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/17.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () ->()) {

        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            //对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //是否分组数据
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                //创建组
                let group = AnchorGroup()
                
                //遍历dataArray的所有字典
                for dict in  dataArray {
                    group.anchors.append(AnchorModel(dict : dict))
                }
                
                //将group添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
        }
    }
}
