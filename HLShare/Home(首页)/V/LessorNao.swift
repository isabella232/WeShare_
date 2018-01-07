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
    func listForTender<R: Result>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>(url:"demand"), success: success, failure: failure)
    }

}

class ProvisionNao: GNao {
    
    static let share = ProvisionNao(url: "/lease/lessor/provision")
    
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


