//
//  PagerPresenter.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class Presenter {
    
    var nao: Nao? = nil
    
    /// 执行 不需要指定 nao
    ///
    /// - Parameters:
    ///   - querier: 参数集
    func execute<R: Result>(nao: Nao, querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock){
        querier.success = success
        querier.failure = failure
        nao.excute(querier: querier)
    }
    
    
    /// 执行 不需要指定 nao
    ///
    /// - Parameters:
    ///   - querier: 参数集
    func execute<R: Result>(_ querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock) {
        execute(nao: nao!, querier: querier, success: success, failure: failure)
    }
    
    /// 统一处理
    /// 基类里面处理 callback
    ///
    /// - Parameter querier: 参数集
    func execute<R: Result>(_ querier: Querier<R>) {
        
        execute(nao: nao!, querier: querier, success: { (result) in
            if let desc =  querier.desc{
                print("操作成功: \(desc)........")
            }
        }) { (code, msg) in
            
            print("操作失败........")
        }
    }
}

// 分页
class PagerPresenter: Presenter {
    var pager: Pager?
    override func execute<R: Result>(nao: Nao, querier: Querier<R>, success: @escaping successBlock<R>, failure: @escaping failureBlock){
        if let p = pager {querier.pager = p}
        return super.execute(nao: nao, querier: querier, success: success, failure: failure)
    }
}












