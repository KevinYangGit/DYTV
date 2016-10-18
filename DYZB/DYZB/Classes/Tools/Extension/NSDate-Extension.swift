//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/17.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import Foundation

extension Date {

    static func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
