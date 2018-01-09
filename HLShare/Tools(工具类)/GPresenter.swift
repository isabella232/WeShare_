//
//  PagerPresenter.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit



class GPresenter<R> {
    
    var pid : Int = 0
    /** 操作类型 */
    var operation : Int = 0
    
    /** 默认的NAO */
    var nao : GNao<R>? = nil
   
    /** 默认的查询器 */
    var querier : GQuerier<R>? {return nil}
    
    private var success :successBlock<R>!
    
    private var failure :failureBlock!
    
    // 分页器
    var pager: GPager?

    
    func execute(nao: GNao<R>,querier: GQuerier<R>)  {
        if let p = pager {querier.pager = p}
        nao.execute(querier: querier, success: success, failure: failure)
    }
    
    /// 执行网络请求
    func execute()  {
        execute(nao: nao!, querier: querier!)
    }
    
    
    /// 网络请求的回调
    func response(success: @escaping successBlock<R>, failure: @escaping failureBlock) {
        self.success = { reuslt in
            success(reuslt)
        }
        self.failure = { (code,msg) in
            failure(code,msg)
        }
    }
}













