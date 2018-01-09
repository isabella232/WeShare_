//
//  SaleItemsNao.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class SaleItemsNao: GNao<saleItemsResult> {

    class SaleItemsNao: GNao<saleItemsResult> {
        private static let share = SaleItemsNao(url: "/lease")
        static func SaleItemsInstance()->SaleItemsNao{return share}
    }
    
}

class SaleItemsListNao: GNao<saleItemsResult> {
    private static let share = SaleItemsListNao(url: "/lease")
    static func saleItemsListInstance()->SaleItemsListNao{return share}
    
    /// 卖家物品列表
    ///
    /// - Parameters:
    ///   - userId: 用户的用户名。空表示获取当前用户的销售项列表，非空表示获取该指定用户发布的销售项列表。
    ///   - extra: 1：获取当前用户关注用户的销售项列表。2：获取当前用户好友的销售项列表。10：获取所有相关用户的销售项列表。
    static func getVendorSaleItemsListQuerier() -> GQuerier<saleItemsResult> {
        let q = GQuerier<saleItemsResult>("sale")
//        if let id = userId {q.params.updateValue(id, forKey: "userId")}
//        q.params.updateValue(extra, forKey: "extra")
        return q
    }
    static func getBuyerSaleItemListQuerier()-> GQuerier<saleItemsResult>{
        return GQuerier<saleItemsResult>("sale")
    }
    
}
