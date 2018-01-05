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
        
        if let pager = querier.pager {
            querier.param.updateValue(pager.page, forKey: "pager.page")
            if pager.pageSize > 0 {querier.param.updateValue(pager.pageSize, forKey: "pager.pageSize")}
            if pager.pad != 0 {querier.param.updateValue(pager.pad, forKey: "pager.pad")}
        }

        return querier
    }
    
    func excute<R: Result>(querier: Querier<R>) {
        NetworkManager.POST(querier: processQuerier(querier: querier))
    }
    
    
    
    
}



class Querier<R> {
    
    var url: String = ""
    
    var param: [String: Any] =  ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var desc: String? = nil //网络回调的 描述
    
    var success: successBlock<R>!
    
    var failure: failureBlock!
    
    var pager: Pager?
   
}

/**
 * 分页器
 * @author BraveLu
 */
class Pager {
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


































