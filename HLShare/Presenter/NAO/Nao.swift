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
    
    var nao: Nao? = nil
    
    /// 执行 不需要指定 nao
    ///
    /// - Parameters:
    ///   - querier: 参数集
    func execute<R: Result>(nao: Nao, querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock){
        querier.success = success
        querier.failure = failure
        nao.excute(querier: querier)
    }
    
    
    /// 执行 不需要指定 nao
    ///
    /// - Parameters:
    ///   - querier: 参数集
    func execute<R: Result>(_ querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock) {
        execute(nao: nao!, querier: querier, success: success, failure: failure)
    }
    
    /// 统一处理
    /// 基类里面处理 callback
    ///
    /// - Parameter querier: 参数集
    func execute<R: Result>(_ querier: Querier<R>) {
        
        execute(nao: nao!, querier: querier, success: { (result) in
            if let desc =  querier.desc{
                print("操作成功: \(desc)........")
            }
        }) { (code, msg) in
            
            print("操作失败........")

        }
    }
    
}

class Nao{
    
    var baseUrl = ""
    var baseParam = [String: Any]()
    var showMsg = ""
    func processQuerier<R>(querier: Querier<R>) -> Querier<R> {
        
        querier.url = baseUrl + querier.url
        
        if let t = app_request_token {
            querier.param.updateValue(t, forKey: "token")
        }
        
        for (key,value) in baseParam{
            querier.param.updateValue(value, forKey: key)
        }

        return querier
    }
    
    func excute<R: Result>(querier: Querier<R>) {
        HLNetworkManager.POST(querier: processQuerier(querier: querier))
    }
    
}



class Querier<R> {
    
    var url: String = ""
    
    var param: [String: Any] =  ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var desc: String? = nil //网络回调的 描述
    
    var success: successBlock<R>!
    
    var failure: failureBlock!
    
}












































