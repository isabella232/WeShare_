//
//  ComboView.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

//import Foundation
import UIKit

/**
 * 组合视图。内含对实体的操作，以及对实体列表的操作。
 * @param <E> 实体/元素操作返回类型
 * @param <L> 列表操作返回类型
 * @param <I> input操作返回类型
 * @author BraveLu
 */
class ComboView<E, L, I> : EntityView<E, I> {
    
    /** base "inner class" for callbacks */
    class InnerComboOpView<T, E, L, I> : OpViewEx<T> {
        var outer : ComboView<E, L, I>
        init(_ outer : ComboView<E, L, I>) {
            self.outer = outer
            super.init()
        }
    }
    /** 列表操作的回调视图 */
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
    
    /** 组合Presenter。将在构造时自动创建。 */
    var comboPresenter : ComboPresenter<E, L>?
    /** 内嵌的实体Presenter。一般包含在组合Presenter内。 */
    override var entityPresenter : EntityPresenter<E>? {return comboPresenter?.entityPresenter}
    
	/** 创建对应的组合Presenter。子类必须提供。 */
	func createComboPresenter() -> ComboPresenter<E, L>? {return nil}

	/** 公共构造方法 */
	override func commonInit() {
        listView = ListView<L>(self)
		comboPresenter = createComboPresenter()
       //simpleOpView = SimpleOpView<E>(self)
        //inputOpView = SimpleOpView<I>(self)
        //editQuerierProcessor = EditQuerierProcessor(self)
        //inputQuerierProcessor = InputQuerierProcessor(self)
        //listView.operationName = "获取\(entityName)列表"
        super.commonInit()
    }
    
	/** 列表操作成功的最终回调处理 */
	func showList(_ response : L) {
		print("Please show the list here.")
	}

	/** 分页器 */
    var pager : Pager? = nil
	
    /** 列表操作回调视图 */
    var listView : ListView<L>? = nil
	
    /** 准备下一页 */
    func increasePage() -> Int {
        if pager==nil {
            pager = Pager(1)
        } else {
            pager!.increase()
        }
        return pager!.page
    }
	
    /** 获取列表 */
    func onCmdList() {
        let listPresenter = comboPresenter!.listPresenter
        if (pager != nil) { listPresenter!.pager = pager }
        listPresenter!.listener = IListener(listView!)
        listPresenter!.execute()
    }
    
}
