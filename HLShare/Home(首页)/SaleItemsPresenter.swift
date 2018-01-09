//
//  SaleItemPresenter.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit



class SaleItemsListPresenter: GPresenter<saleItemsResult> {
    override init() {
        super.init()
        nao = SaleItemsListNao.saleItemsListInstance()
    }

}

class VendorSaleItemsListPresenter: SaleItemsListPresenter {
    override var querier: GQuerier<saleItemsResult>?{
        var q = SaleItemsListNao.getVendorSaleItemsListQuerier()
        return q
    }
}

class BuyerSaleItemsListPresenter: SaleItemsListPresenter {
    override var querier: GQuerier<saleItemsResult>?{
        return SaleItemsListNao.getBuyerSaleItemListQuerier()
    }
}
