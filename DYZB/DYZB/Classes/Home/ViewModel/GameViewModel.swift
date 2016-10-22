//
//  GameViewModel.swift
//  DYZB
//
//  Created by boxfishedu on 2016/10/21.
//  Copyright © 2016年 杨琦. All rights reserved.
//

import UIKit

class GameViewModel: BaseGameModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.games.append(GameModel(dict : dict))
            }
            
            finishedCallback()
        }
    }
}
