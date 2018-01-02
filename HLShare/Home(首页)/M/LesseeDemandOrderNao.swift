//
//  LesseeDemandOrderPresenter.swift
//  HLShare
//
//  Created by HLApple on 2017/12/28.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit


//租方 订单
class LesseeDemandOrderNao: Nao{
    
    /// 卖家商品列表
//    static func getBuyerOrder()->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/lease/lessor/demand!find"
//        querier.param = ["":""]
//        return querier
//    }

    
    /// 租方 订单列表
    ///
    /// - Parameters:
    /// - userId: 用户的用户名,空表示获取当前用户的需求列表，非空表示获取该指定用户发布的需求列表。
    /// - extra: 1：获取当前用户关注用户的需求列表。2：获取当前用户好友的需求列表。10：获取所有相关用户的需求列表
    /// - Returns:
    static func getLesseeDemandOrderQuerier(_ userId: String = "",_ extra: Int = 10)-> Querier{
        let querier = Querier()
        querier.url = "/lease/lessee/order"
        querier.param.updateValue(userId, forKey: "userId")
        querier.param.updateValue(extra, forKey: "extra")
        return querier
    }
    
    
    
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
class LesseeDemandOrderPresenter: Presenter {
    
    /// <#Description#>
    override var nao: Nao?{return LesseeDemandOrderNao()}
    
    
    /// <#Description#>
    override var querier: Querier?{return LesseeDemandOrderNao.getLesseeDemandOrderQuerier()}
    
    
    /// 租方 订单列表
    func getLesseeDemandOrder(success: @escaping successBlock,failure:@escaping failureBlock) {
        execute(json: DemandsResult.self, success: success, failure: failure)
    }
    
//
//    func pay(money: String,balanceDeducted: Bool,success: @escaping successBlock,failure:@escaping failureBlock)  {
//        execute(HandyJSON: Result.self, nao: LesseeDemandOrderNao(), querier: LesseeDemandOrderNao.pay(money: money, balanceDeducted: balanceDeducted), success: success, failure: failure)
//    }
//
//    // 投标
//    func tender(id: Int? = nil,demandId: Int?,success: @escaping successBlock,failure:@escaping failureBlock)  {
//        execute(HandyJSON: Result.self, nao: LesseeDemandOrderNao(), querier: LesseeDemandOrderNao.tender(id: id,demandId: demandId), success: success, failure: failure)
//    }
//
//    // 修改投标
//    func tenderEdit(id: Int?,demandId: Int? = nil,success: @escaping successBlock,failure:@escaping failureBlock)  {
//        execute(HandyJSON: Result.self, nao: LesseeDemandOrderNao(), querier: LesseeDemandOrderNao.tenderEdit(id: id,demandId: demandId), success: success, failure: failure)
//    }
    
    
}
