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


class Presenter {
    
    var nao: Nao?
    
    var querier: Querier?
    
    var listener: Listener?
    
    func execute(nao: Nao, querier: Querier,listener: Listener,json: Result.Type){
        querier.listener = listener
        nao.excute(querier: querier, json: json)
    }
    
    func execute(json: Result.Type) {
        execute(nao: nao!, querier: querier!, listener: listener!,json: Result.self)
    }
}

class Nao{
    func excute(querier: Querier,json: Result.Type) {
        querier.param.updateValue("true", forKey: "silent")
        if let t = app_request_token {
            querier.param.updateValue(t, forKey: "token")
        }
        HLNetworkManager.POST(url: BASEURL + querier.url, param: querier.param, listener: querier.listener!,json: json)
    }

}

class Querier {
    
    var url: String!
    
    var param =  [String: Any]()
    
    var listener: Listener?
    
}


class Listener {
    
    func success(_ dev: Result) -> Void{
        
    }
    func failure(_ code: Int,_ msg: String) -> Void{
        
    }
}









































