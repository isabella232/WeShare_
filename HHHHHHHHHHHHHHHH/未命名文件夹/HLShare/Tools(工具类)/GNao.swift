//
//  HLBaseNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit




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


class GNao<R>{
    var baseUrl = ""
    var baseParam = [String: Any]()
    var showMsg = ""
    
    init(url: String) {self.baseUrl = url}
    
    func processQuerier<R>(querier: GQuerier<R>) -> GQuerier<R> {
        
        querier.url = baseUrl + querier.url
        
        if let t = Config.token {
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
    
    func execute<R>(querier: GQuerier<R>, success:@escaping successBlock<R>, failure: @escaping failureBlock)  {
        querier.success = success
        querier.failure = failure
        NetworkManager.POST(querier: processQuerier(querier: querier) as! GQuerier<Result>)
    }
}

class OperationsNao<R>: GNao<R>{
    
    /* - demandId: 投标 **/
    func input(demandId: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>( OrderOperation.input)
        q.params.updateValue(demandId, forKey: "demandId")// 投标
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 改标 **/
    func input<R: Result>(id: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>( OrderOperation.input)
        q.params.updateValue(id, forKey: "id")// 投标
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 提交 标书 **/
    func edit<R: Result>(demandId: Int,saleItemId: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>( OrderOperation.edit)
        q.params.updateValue(demandId, forKey: "demandId")
        q.params.updateValue(saleItemId, forKey: "saleItemId")
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 修改 标书 **/
    func edit<R: Result>(id: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>( OrderOperation.edit)
        q.params.updateValue(id, forKey: "id")
        q.params.updateValue(id, forKey: "saleItem.name")
        q.params.updateValue(id, forKey: "saleItem.content")
        q.params.updateValue(id, forKey: "saleItem.price")
        q.params.updateValue(id, forKey: "saleItem.deposit")
        q.params.updateValue(id, forKey: "saleItem.location.longitude")
        q.params.updateValue(id, forKey: "saleItem.location.latitude")
        q.params.updateValue(id, forKey: "saleItem.place")
        execute(querier: q, success: success, failure: failure)
    }
    
    
    /*   - id: 撤标 **/
    func delete<R: Result>(id: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>( OrderOperation.delete)
        q.params.updateValue(id, forKey: "id")
        execute(querier: q, success: success, failure: failure)
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
    
    init(_ operate: OrderOperation) {
        url = operate.rawValue
    }
   
    init(_ url: String) {
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


































