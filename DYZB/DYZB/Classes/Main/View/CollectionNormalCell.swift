//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/15.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    //控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //定义模型属性
    override var anchor: AnchorModel? {
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            
            //房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
