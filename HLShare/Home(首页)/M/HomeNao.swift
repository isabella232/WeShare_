//
//  HomeNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class HomeNao{

    /// 列出需求借口
    ///
    /// - Parameters:
    /// - userId: 用户的用户名,空表示获取当前用户的需求列表，非空表示获取该指定用户发布的需求列表。
    /// - extra: 1：获取当前用户关注用户的需求列表。2：获取当前用户好友的需求列表。10：获取所有相关用户的需求列表
    /// - Returns:
//    static func getNearlyDemand(_ userId: String = "",_ extra: Int = 10)-> HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/lease/lessee/demand"
//        querier.param = ["userId":userId,"extra":extra]
//        return querier
//    }
//
//
//    /// 卖家商品列表
//    static func getBuyerOrder()->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/lease/lessor/demand!find"
//        querier.param = ["":""]
//        return querier
//    }
    
    
    /// 下单
    ///
    /// - Parameters:
    ///   - money: 💰
    ///   - balanceDeducted:
//    static func pay(money: String,balanceDeducted: Bool)->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/lessee/order!pay"
//        querier.param = ["balanceDeducted":false,"money":money]
//        return querier
//    }
    
    
    /// 3.1.3　    投标
    ///
    /// - Parameters:
    ///   - id: 供给ID。空表示新建，非空表示修改。
    ///   - demandId: 需求ID。仅当id不为空时，本参数可以为空。
    /// - Returns: <#return value description#>
//    static func tender(id: Int? = nil,demandId: Int?)->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "lease/lessor/provision!input"
//        if id == nil {
//            querier.param = ["demandId":demandId!]
//        }else{
//            querier.param = ["id":id!]
//        }
//        return querier
//    }
    
    /// 3.1.3　    修改投标
    ///
    /// - Parameters:
    ///   - id: 供给ID。空表示新建，非空表示修改。
    ///   - demandId: 需求ID。仅当id不为空时，本参数可以为空。
    /// - Returns: <#return value description#>
//    static func tenderEdit(id: Int?,demandId: Int?)->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "lease/lessor/provision!edit"
//        if id == nil {
//            querier.param = ["demandId":demandId!]
//        }else{
//            querier.param = ["id":id!,"saleItem":"21"]
//        }
//        return querier
//    }
    
    
    /// 删除订单
    ///
    /// - Parameter orderId: 订单id
    /// - Returns:
//    static func delete(orderId: Int)->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/order!delete"
//        querier.param = ["id":orderId]
//        return querier
//    }
}
