//
//  HLBasePresenter.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class HLBasePresenter<L: OnResponse> {
    
    lazy var nao = HLBaseNao<L>()
    
    var querier: HLBaseQuerier<L>?
    
    var listener: L?

    lazy var pid: Int = 0
    
    
    func execute(nao: HLBaseNao,querier: HLBaseQuerier<L>,listener: L){
        querier.listener = listener
        nao.excute(netQuerier: querier)
    }
    
    func execute() {
        execute(nao: nao, querier: querier!, listener: listener!)
    }
    
    
}




