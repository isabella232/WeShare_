//
//  File.swift
//  HLShare
//
//  Created by HLApple on 2018/1/6.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class LeaseNao: GNao {
    
    static let share = LeaseNao(url: "/lease/lessee/")
    
    // 查找附近需求
    func listDemand<R: DemandsResult>(success:@escaping successBlock<R>, failure: @escaping failureBlock){
        execute(querier: GQuerier<R>(url:"demand"), success: success, failure: failure)
    }
   
}
