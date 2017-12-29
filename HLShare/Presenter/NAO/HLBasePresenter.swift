//
//  HLBasePresenter.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class HLBasePresenter {
    lazy var m_nao = HLBaseNao()
    lazy var m_listener = HLBaseListener()
    lazy var m_querier = HLBaseQuerier()
    
    func execute<T: Result>(HandyJSON: T.Type,nao: HLBaseNao,querier: HLBaseQuerier,listener: HLBaseListener) -> Void {
        nao.excute(netQuerier: querier, dov: HandyJSON)
    }
    
    func execute() {
        execute(HandyJSON: Result.self, nao: m_nao, querier: m_querier, listener: m_listener)
    }
}

