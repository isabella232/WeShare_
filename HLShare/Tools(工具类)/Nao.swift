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

enum OrderOperation: String {
    
    case input          = "!input"
    case edit           = "!edit"
    case delete         = "!delete"
    case report //举报
    case lookupDetails
    case lookupVendor
    case lookupBuyer
    case pay
    case cancel
    case review
    case startUse
}

//protocol ProcessQuerier {
//    associatedtype R: Result
//    func processQuerier<R>(querier: GQuerier<R>) -> GQuerier<R>
//}

class GNao{
    var baseUrl = ""
    var baseParam = [String: Any]()
    var showMsg = ""
    
    init(url: String) {self.baseUrl = url}
    
    func processQuerier<R>(querier: GQuerier<R>) -> GQuerier<R> {
        
        querier.url = baseUrl + querier.url
        
        if let t = app_request_token {
            querier.params.updateValue(t, forKey: "token")
        }
        
        for (key,value) in baseParam{
            querier.params.updateValue(value, forKey: key)
        }
        
        if let pager = querier.pager {
            querier.params.updateValue(pager.page, forKey: "pager.page")
            if pager.pageSize > 0 {querier.params.updateValue(pager.pageSize, forKey: "pager.pageSize")}
            if pager.pad != 0 {querier.params.updateValue(pager.pad, forKey: "pager.pad")}
        }

        return querier
    }
    
    func execute<R: Result>(querier: GQuerier<R>, success:@escaping successBlock<R>, failure: @escaping failureBlock)  {
        querier.success = success
        querier.failure = failure
        NetworkManager.POST(querier: processQuerier(querier: querier))
    }
}



class GQuerier<R> {
    
    var url: String = ""
    
    var params: [String: Any] =  ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var desc: String? = nil //网络回调的 描述
    
    var success: successBlock<R>!
    
    var failure: failureBlock!
    
    var pager: GPager?
    
    init(operate: OrderOperation) {
        url = operate.rawValue
    }
   
    init(url: String) {
        self.url = url
    }
}

/**
 * 分页器
 * @author BraveLu
 */
class GPager {
    /** 页码 */
    var page : Int = 0
    /** 每页长度。0将被忽略。 */
    var pageSize : Int = 0
    /** 填充量，表示待获取记录之前实际被删除的元素数目 */
    var pad : Int = 0
    
    init() {}
    init(_ page : Int) {
        self.page = page;
    }
    init(_ page : Int , _ pageSize : Int) {
        self.page = page;
        self.pageSize = pageSize;
    }
    /**
     * 增加一页
     * @return
     */
    func increase() -> Int {
        page += 1
        return page
    }
    /**
     * 填充到参数集中
     * @param params 参数集
     */
    func fill(_ params : inout [String: Any]) {
        params["pager.page"] = page
        if (pageSize > 0) { params["pager.pageSize"] = pageSize }
        if (pad != 0) { params["pager.pad"] = pad }
    }
    
}


































