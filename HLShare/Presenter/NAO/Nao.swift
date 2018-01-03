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
    
    var nao: Nao?{return nil}
    
    func execute<R: Result>(nao: Nao, querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock){
        querier.success = success
        querier.failure = failure
        nao.excute(querier: querier)
    }
    
    
//    func execute(success: @escaping successBlock<Result>, failure: @escaping failureBlock) {
//        execute(nao: nao!, querier: querier!, success: success, failure: failure)
//    }
}

class Nao{
    var baseParams = [String: Any]()
    func excute<R: Result>(querier: Querier<R>) {
        if let t = app_request_token {querier.param.updateValue(t, forKey: "token")}
        HLNetworkManager.POST(querier: querier)
    }
    
}



class Querier<R> {
    
    var url: String!
    
    var param: [String: Any] =  ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var success: successBlock<R>!
    
    var failure: failureBlock!
    
}












































