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
    
    var querier: Querier?{return nil}
    
    func execute<R: Result>(nao: Nao, querier: Querier, Result: R.Type, success: @escaping successBlock, failure: @escaping failureBlock){
        querier.success = success
        querier.failure = failure
        nao.excute(querier: querier,   Result:   Result)
    }
    
    func execute<R: Result>(  Result: R.Type, success: @escaping successBlock, failure: @escaping failureBlock) {
        execute(nao: nao!, querier: querier!, Result: Result, success: success, failure: failure)
    }
}

class Nao{
    func excute<R: Result>(querier: Querier, Result: R.Type) {
        if let t = app_request_token {querier.param.updateValue(t, forKey: "token")}
        HLNetworkManager.POST(querier: querier, Result: Result)
    }
    
}



class Querier {
    
    var url: String!
    
    var param: [String: Any] =  ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var success: successBlock!
    
    var failure: failureBlock!
    
}












































