//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/15.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    //控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            
            //所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
