//
//  DemandNao.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class DemandNao: GNao<Result> {
    private static let share = DemandListNao(url: "/lease")
    static func demandListInstance()->DemandListNao{return share}
}

class DemandListNao: GNao<DemandsResult> {
    private static let share = DemandListNao(url: "/lease")
    static func demandListInstance()->DemandListNao{return share}

    // 供给方需求
    static func getVendorDemandQuerier() ->GQuerier<DemandsResult> {
        let querier = GQuerier<DemandsResult>("/lessor/demand!find")
        return querier
    }
    
    // 供给方 已投标需求
    static func getVendorForTendorDemandQuerier() ->GQuerier<DemandsResult> {
        let querier = GQuerier<DemandsResult>("/lessor/demand")
        return querier
    }
    
    // 买家需求
    static func getBuyerDemandQuerier() ->GQuerier<DemandsResult> {
        let querier = GQuerier<DemandsResult>("/lessee/demand")
        return querier
    }
    
    
  
    
}
