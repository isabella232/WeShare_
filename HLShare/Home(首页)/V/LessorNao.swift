//
//  File.swift
//  HLShare
//
//  Created by HLApple on 2018/1/6.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class LessorNao: GNao {
    
    static let share = LessorNao(url: "/lease/lessor/")
    
    // 查找附近需求
    func listDemand<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>(url:"demand!find"), success: success, failure: failure)
    }
    // 已投标的需求 列表
    func listForTender<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>(url:"demand"), success: success, failure: failure)
    }

    /// 列出销售项
    ///
    /// - Parameters:
    ///   - userId: 用户的用户名。空表示获取当前用户的销售项列表，非空表示获取该指定用户发布的销售项列表。
    ///   - extra: 1：获取当前用户关注用户的销售项列表。2：获取当前用户好友的销售项列表。10：获取所有相关用户的销售项列表。
    func listForSale<R: saleItemsResult>(userId: String? = nil,extra: Int = 10, success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(url:"sale")
        if let id = userId {q.params.updateValue(id, forKey: "userId")}
        q.params.updateValue(extra, forKey: "extra")
        execute(querier: q, success: success, failure: failure)
    }
    
    
    /// 我的订单列表
    ///
    /// - Parameters:
    ///   - state:  0 all, 1 活动订单 2 history
    func listForOrder<R: OrdersResult>(state: Int = 0, success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(url:"order")
        q.params.updateValue(state, forKey: "state")
        execute(querier: q, success: success, failure: failure)
    }
}

class LessorOperationNao: OperationsNao {
    static let share = LessorOperationNao(url: "lease/lessor/provision")
}

class OperationsNao: GNao {
    
    /* - demandId: 投标 **/
    func input<R: Result>(demandId: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(operate: OrderOperation.input)
        q.params.updateValue(demandId, forKey: "demandId")// 投标
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 改标 **/
    func input<R: Result>(id: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(operate: OrderOperation.input)
        q.params.updateValue(id, forKey: "id")// 投标
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 提交 标书 **/
    func edit<R: Result>(demandId: Int,saleItemId: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(operate: OrderOperation.edit)
        q.params.updateValue(demandId, forKey: "demandId")
        q.params.updateValue(saleItemId, forKey: "saleItemId")
        execute(querier: q, success: success, failure: failure)
    }
    
    /*   - id: 修改 标书 **/
    func edit<R: Result>(id: Int,success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>(operate: OrderOperation.edit)
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
        let q = GQuerier<R>(operate: OrderOperation.delete)
        q.params.updateValue(id, forKey: "id")
        execute(querier: q, success: success, failure: failure)
    }
    
}


