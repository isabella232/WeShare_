//
//  LesseeDemandOrdersDvo.swift
//  HLShare
//
//  Created by HLApple on 2018/1/3.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit


/// 供给方 订单列表
class ListLeaseOrdersResult: ListResult<LeaseOrderDvo> {
    var orders: [LeaseOrderDvo]?
	override var getEntities: [LeaseOrderDvo]? {return orders}
    required init() {}
}

/// 供给方 订单UI
class LesseeOrderInputResult: Result {
    var saleItem: saleItem?
    var order: OrderDvo?
}

class OrderDvo: Dvo {
    
    var item: Item?
    
    /** 买家 */
    var buyer: UserDvo?
    
    /** 卖家 */
    var vendor: UserDvo?
    
    /** 应付金额 */
    var due: Float = 0.0
    
    /** 实付金额 */
    var paid: Float = 0.0
    
    /** 支付模式 */
    var payMode: Int = 0
    
    class Item: Dvo {
        var saleItem: saleItem?
        required init() {}
    }
    
    required init() {}
    
}

class LeaseOrderDvo: OrderDvo { required init(){} }

