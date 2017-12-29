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


class HLBaseNao<L: OnResponse> {
    
    func excute(netQuerier: HLBaseQuerier<L>) {
        netQuerier.param.updateValue("true", forKey: "silent")
        if let t = app_request_token {
            netQuerier.param.updateValue(t, forKey: "token")
        }
    
        HLNetworkManager.POST(url: BASEURL + netQuerier.url, param: netQuerier.param,listener: netQuerier.listener)
    }
    
    
    
    
}



