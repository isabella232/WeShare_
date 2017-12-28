//
//  HLBaseNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

/// 全局变量  登录的token
var app_request_token: String?


class HLBaseNao {
    
    //static let share  =  HLBaseNao()
       
    func excute<T: Result>(netQuerier: HLBaseQuerier,dov:T.Type) {
        netQuerier.param.updateValue("true", forKey: "silent")
        if let t = app_request_token {
            netQuerier.param.updateValue(t, forKey: "token")
        }
        HLNetworkManager.POST(url: BASEURL + netQuerier.url, param: netQuerier.param, Dvo: dov, listener: netQuerier.listener)
    }
    
    
    /// 生成网络请求参数的对象
    /// 子类需要重写 querier 方法给 querier 注入参数
    /// - Returns: NetQuerier
    static func querier() -> HLBaseQuerier {
        return HLBaseQuerier()
    }
    
}



