//
//  HomeModel.swift
//  HLShare
//
//  Created by HLApple on 2017/12/25.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit



/// 供给方需求
class DemandsResult: Result{
    
    var demands: [Demand]?
        
    required init() {}
    
    class Demand: PoiDvo {
        
        var fileDvos: [FileDvo]?
        
        var badeProvision: badeProvision?

        /** 需求价格 */
        var price: Float?
        
        /** （当前用户作为需方时）投标的数量 */
        var badeProvisionCount: Int?
        
        required init() {}
        class badeProvision: Dvo {
            var saleItem: saleItem?
            var provider: UserDvo?
            required init() {}
        }
    }
}

class saleItemsResult: Result {
    var saleItems: [saleItem]?
    required init() {}
}

class OrdersResult: Result {
    var orders: [OrderDvo]?
    required init() {}
}



