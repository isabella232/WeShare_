//
//  File.swift
//  HLShare
//
//  Created by HLApple on 2018/1/6.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class LeaseNao: GNao<DemandsResult>{
    
    static let share = LeaseNao(url: "/lease/lessee/")
    
    // 我的需求
    func listDemand<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>("demand"), success: success, failure: failure)
    }
    
    // 销售项管理
    func listForSale<R: saleItemsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>("sale"), success: success, failure: failure)
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

class LeaseOperationNao: OperationsNao<Result> {
    static let share = LeaseOperationNao(url: "lease/lessor/demand")
}
