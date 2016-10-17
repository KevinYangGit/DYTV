//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/15.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    
    var anchor : AnchorModel?  {
    
        didSet {
        
            //校验模型是否有值
            guard let anchor = anchor else { return }
            
            var onlineStr : String = ""
//            if anchor.online >= 10000 {
//                onlineStr = "\(Int(anchor.online / 10000))万在线"
//            } else {
//                onlineStr = "\(anchor)"
//            }
//            
        }
    }
    
}
