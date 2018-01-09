//
//  DemandPresenter.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class DemandPresenter: GPresenter<DemandsResult>{
    override init() {
        super.init()
    }
}

class DemandListPresenter: GPresenter<DemandsResult>{
    override init() {
        super.init()
        nao = DemandListNao.demandListInstance()
    }
}

class BuyerDemandListPresenter: DemandListPresenter {
    override var querier: GQuerier<DemandsResult>?{
        return DemandListNao.getBuyerDemandQuerier()
    }
}
class VendorDemandListPresenter: DemandListPresenter {
    override var querier: GQuerier<DemandsResult>?{
        return DemandListNao.getVendorDemandQuerier()
    }
}

// 投标的需求列表
class VendorForTenderDemandListPresenter: DemandListPresenter {
    override var querier: GQuerier<DemandsResult>?{
        return DemandListNao.getVendorForTendorDemandQuerier()
    }
}
