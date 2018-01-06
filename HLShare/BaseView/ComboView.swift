//
//  ComboView.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation
import UIKit

/**
 * 组合视图。内含对实体的操作，以及对实体列表的操作。
 * @param <E> 实体/元素操作返回类型
 * @param <L> 列表操作返回类型
 * @param <I> input操作返回类型
 * @author BraveLu
 */
class ComboView<E, L, I> : EntityView<E, I> {
    
    //{{=======================common cross platforms===============================
    /** base "inner class" for callbacks */
    class InnerComboOpView<T, E, L, I> : OpViewEx<T> {
        var outer : ComboView<E, L, I>
        init(_ outer : ComboView<E, L, I>) {
            self.outer = outer
            super.init()
        }
    }
    /** list operation callback */
    class ListView<L> : InnerComboOpView<L, E, L, I> {
        //        var outer : ComboView<E, L>
        //        init(_ outer : ComboView<E, L>) {
        //            self.outer = outer
        //            super.init()
        //        }
        //override init(_ outer : ComboView<E, L>) {super.init(outer)}
        override var operationName : String {return "获取\(outer.entityName)列表"}
        override func show(_ response: L , _ querier : Querier<L>?) {
            super.show(response , querier)
            outer.showList(response)
        }
    }
    
    /** the final callback for list operation */
    func showList(_ response : L) {
        print("Please show the list here.")
    }
    /** 组合Presenter */
    var comboPresenter : ComboPresenter<E, L>?
    
    override var entityPresenter : EntityPresenter<E>? {return comboPresenter?.entityPresenter}
    
    override func commonInit() {
        listView = ListView<L>(self)
        //simpleOpView = SimpleOpView<E>(self)
        //inputOpView = SimpleOpView<I>(self)
        //editQuerierProcessor = EditQuerierProcessor(self)
        //inputQuerierProcessor = InputQuerierProcessor(self)
        comboPresenter = createComboPresenter()
        //listView.operationName = "获取\(entityName)列表"
        super.commonInit()
    }
    
    /** 分页器 */
    var pager : Pager? = nil
    /** 列表操作视图 */
    //    var listView : OpView<L> = OpView<L>()
    //    {
    //        override var operationName {return "获取\(entityName)列表"}
    //    };
    var listView : ListView<L>? = nil
    
    /** 创建对应的组合Presenter */
    func createComboPresenter() -> ComboPresenter<E, L>? {return nil}
    /** 准备下一页 */
    func increasePage() -> Int {
        if pager==nil {
            pager = Pager(1)
        } else {
            pager!.increase()
        }
        return pager!.page
    }
    //    /** 获取列表 */
    //    func onCmdList() {
    //        var listPresenter = comboPresenter!.listPresenter
    //        if (pager != nil) { listPresenter!.pager = pager }
    //        //listPresenter!.listener = IListener(listView)
    //        listPresenter!.fnOnResponse =  { (response , querier) in
    //            if response is ListLeaseOrdersResult {
    //                print("回应：;ladfjas;dfasdfasdasf")
    //            }
    //        }
    //        listPresenter!.execute()
    //    }
    /** 获取列表 */
    func onCmdList() {
        let listPresenter = comboPresenter!.listPresenter
        if (pager != nil) { listPresenter!.pager = pager }
        listPresenter!.listener = IListener(listView!)
        listPresenter!.execute()
    }
    
}
