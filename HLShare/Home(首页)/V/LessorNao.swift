//
//  File.swift
//  HLShare
//
//  Created by HLApple on 2018/1/6.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class LessorNao: GNao<DemandsResult> {
    
    static let share = LessorNao(url: "/lease/lessor/")
    
    // 查找附近需求
    func listDemand<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>("demand!find"), success: success, failure: failure)
    }
    // 已投标的需求 列表
    func listForTender<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>("demand"), success: success, failure: failure)
    }

   
    func listForSale<R: saleItemsResult>(userId: String? = nil,extra: Int = 10, success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>("sale")
        if let id = userId {q.params.updateValue(id, forKey: "userId")}
        q.params.updateValue(extra, forKey: "extra")
        execute(querier: q, success: success, failure: failure)
    }
    
    
    /// 我的订单列表
    ///
    /// - Parameters:
    ///   - state:  0 all, 1 活动订单 2 history
    func listForOrder<R: OrdersResult>(state: Int = 0, success:@escaping successBlock<R>, failure: @escaping failureBlock){
        let q = GQuerier<R>("order")
        q.params.updateValue(state, forKey: "state")
        execute(querier: q, success: success, failure: failure)
    }
}

class LessorOperationNao: OperationsNao<Result> {
    static let share = LessorOperationNao(url: "lease/lessor/provision")
}




