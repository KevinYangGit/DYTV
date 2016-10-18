//
//  BaseGameModel.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/17.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //自定义构造函数
    override init() {
    
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
