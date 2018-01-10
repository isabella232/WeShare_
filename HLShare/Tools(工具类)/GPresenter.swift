//
//  PagerPresenter.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

/** 参数加工器 */
protocol ProcessForExtraQuerierProtocol {
    func processForExtraQuerier() -> [String:Any]
}

protocol ResponseHandelProtocol {
    associatedtype Value
    func successHandle(_ response : Value , _ operation : Int) -> Void
    func failureHandle(_ error : Int, _ msg : String , _ operation : Int) -> Void
}

class ResponseHandel<T>:ResponseHandelProtocol {
    
    func successHandle(_ response: T, _ operation: Int) {
        _successHandle(response,operation)
    }
    
    func failureHandle(_ error: Int, _ msg: String, _ operation: Int) {
        _failureHandle(error,msg,operation)
    }
    
    let _successHandle: (T,Int) -> Void
    let _failureHandle: (Int,String,Int) -> Void
    
    init<V: ResponseHandelProtocol>(_ delegatee: V) where V.Value == T {
        _successHandle = delegatee.successHandle
        _failureHandle = delegatee.failureHandle
    }
    
    
    
}



class GPresenter<R: Result> {
    
    typealias ResponseResult = R
    
    var pid : Int = 0
    /** 操作类型 */
    var operation : Int = 0
    
    /** 默认的NAO */
    var nao : GNao<R>? = nil
   
    /** 默认的查询器 */
    var querier : GQuerier<R>? {return nil}
    
    private var success :successBlock<R>!
    
    private var failure :failureBlock!
    
    /** 回调的协议 */
    private var handle: ResponseHandel<R>?
    
    /** 参数加工器 */
    var querierDelegate: ProcessForExtraQuerierProtocol?
    
    
    // 分页器
    var pager: GPager?
    
    /// 执行网络请求
    func execute(nao: GNao<R>,querier: GQuerier<R>)  {
        // 添加分页器
        if let p = pager {querier.pager = p}
        
        // 添加额外的参数
        if let params = querierDelegate?.processForExtraQuerier() {
            for (key,value) in params{
                querier.params.updateValue(value, forKey: key)
            }
        }
        
        
        
        // 添加额外的参数
        self.success = {[unowned self] reuslt in
            self.handle?.successHandle(reuslt, 0)
        }
        
        self.failure = {[unowned self] (code,msg) in
            self.handle?.failureHandle(code!, msg, 0)
        }
        
        // 执行
        nao.execute(querier: querier, success: success, failure: failure)
    }
    
    /// 执行网络请求
    func execute()  {
        execute(nao: nao!, querier: querier!)
    }
    
}













