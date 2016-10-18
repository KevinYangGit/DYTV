//
//  NetworkTools.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/17.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools: NSObject {

    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        
        //获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            //获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            //通过回调返回结果
            finishedCallback(result)
        }
        
    }
}
