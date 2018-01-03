//
//  LesseeDemandOrderPresenter.swift
//  HLShare
//
//  Created by HLApple on 2017/12/28.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit


//需求方 订单
class LesseeDemandOrderNao: Nao{
    
    /// 卖家商品列表
//    static func getBuyerOrder()->HLBaseQuerier{
//        let querier = HLBaseQuerier()
//        querier.url = "/lease/lessor/demand!find"
//        querier.param = ["":""]
//        return querier
//    }

    
    /// 需求方 订单列表
    /// - Parameters:
    /// - state: 订单状态   0-全部订单（默认） 1-活动订单 2-历史订单
    static func getLesseeDemandOrderQuerier(_ state: Int = 0)-> Querier<ListLeaseOrdersResult>{
        let querier = Querier<ListLeaseOrdersResult>()
        querier.url = "/lease/lessee/order"
        querier.param.updateValue(state, forKey: "state")
        return querier
    }
    
    ///  提交订单-UI
    /// - Parameter saleItemId: 待订购的销售项ID
    static func getLesseeOrderInputQuerier(_ saleItemId: Int)-> Querier<Any>{
        let querier = Querier<Any>()
        querier.url = "/lease/lessee/order!input"
        querier.param.updateValue(saleItemId, forKey: "saleItemId")
        return querier
    }
    
    ///  提交订单
    /// - Parameter saleItemId: 待订购的销售项ID
    /// - Parameter payMode: 付款方式。目前支持：1-预付款方式，2-后付款方式。客户端应当根据销售项允许的付款方式，对用户的选择进行限制。
    static func getEditLesseeOrderQuerier(_ saleItemId: Int, _ payMode: Int) -> Querier<Any> {
        let querier = Querier<Any>()
        querier.url = "/lease/lessee/order!edit"
        querier.param.updateValue(saleItemId, forKey: "saleItemId")
        querier.param.updateValue(payMode, forKey: "payMode")
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
    
    override var nao: Nao?{return LesseeDemandOrderNao()}
    
//    override var querier: Querier?{return LesseeDemandOrderNao.getLesseeDemandOrderQuerier()}
    
    /// 租方 订单列表
    func getLesseeDemandOrder(success: @escaping successBlock<ListLeaseOrdersResult>,failure:@escaping failureBlock) {
        let q = LesseeDemandOrderNao.getLesseeDemandOrderQuerier()
        execute(nao: nao!, querier: q, success: successBlock, failure: failureBlock)
    }
    
    /// 提交订单的UI
    func getLesseeOrderInput(saleItemId: Int, success: @escaping successBlock<LesseeOrderInputResult>,failure:@escaping failureBlock)  {
//        execute(nao: nao!, querier: LesseeDemandOrderNao.getLesseeOrderInputQuerier(saleItemId), success: success, failure: failure)
    }
    
    /// 用户填写完订单信息后，执行下单操作。
    func editLesseeOrder(_ saleItemId: Int, _ payMode: Int, success: @escaping successBlock<Result>,failure:@escaping failureBlock) -> Void {
//        execute(nao: nao!, querier: LesseeDemandOrderNao.getEditLesseeOrderQuerier(saleItemId,payMode), success: success, failure: failure)

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
