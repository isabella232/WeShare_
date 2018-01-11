//
//  BaseView.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation
import UIKit

class EntityView<E, I> : UIViewController {
    
    //{{=======================common cross platforms===============================
    
    class InnerEntityOpView<T, E, I> : OpViewEx<T> {
        var outer : EntityView<E, I>
        init(_ outer : EntityView<E, I>) {
            self.outer = outer
            super.init()
        }
    }
    /** any other operations callback */
    class SimpleOpView<T> : InnerEntityOpView<T, E, I> {
        override var operationName : String {return "\(outer.entityName)"}
        override func onError(_ error: Int, _ msg: String, _ querier: Querier<T>?) {
            super.onError(error, msg, querier)
            outer.onFailed(error, msg, querier)
        }
        override func show(_ response: T , _ querier : Querier<T>?) {
            super.show(response , querier)
            outer.onOperated(response , querier)
        }
    }
    /** querier processor for edit operation */
    class EditQuerierProcessor<T> : PQuerierProcessor {
        typealias R = T
        var outer : EntityView<E, I>
        init(_ outer : EntityView<E, I>) {self.outer = outer}
        func processQuerier(_ querier : Querier<R>) -> Querier<R> {
            outer.processEditQuerier(querier)
            return querier
        }
    }
    /** querier processor for input operation */
    class InputQuerierProcessor<T> : PQuerierProcessor {
        typealias R = I
        var outer : EntityView<E, I>
        init(_ outer : EntityView<E, I>) {self.outer = outer}
        func processQuerier(_ querier : Querier<R>) -> Querier<R> {
            outer.processInputQuerier(querier)
            return querier
        }
    }

    /** 实体类型名称 */
    var entityName : String = "实体"
    var operation = 0
    
    var entityPresenter : EntityPresenter<E>? {return nil}
    
    /** 简单操作视图 */
    //var simpleOpView : SimpleOpView<E>? = nil
    //var inputOpView : SimpleOpView<I>? = nil
    func getSimpleOpView() -> SimpleOpView<E> {return SimpleOpView<E>(self)}
    func getInputOpView() -> SimpleOpView<I> {return SimpleOpView<I>(self)}
    //var editQuerierProcessor : EditQuerierProcessor<E>? = nil
    //var inputQuerierProcessor : InputQuerierProcessor<I>? = nil
    func getEditQuerierProcessor() -> EditQuerierProcessor<E> {return EditQuerierProcessor<E>(self)}
    func getInputQuerierProcessor() -> InputQuerierProcessor<I> {return InputQuerierProcessor<I>(self)}
    //    /** 取消视图 */
    //    protected OpView<E> m_cancelView=new OpView<E>() {
    //    @Override public String getOperationName() {return "取消"+m_entityName;}
    //    };
    
    //控件变量
    /** 当前操作的实体ID */
    var id = 0
    //var targetId = 0

    func commonInit() {
        entityPresenter?.listener = IListener(getSimpleOpView())
    }

    /** the final callback for other operations */
    func onOperated<T>(_ response : T , _ querier : Querier<T>?) {
        switch querier!.operation {
            //        case Business.OP_DELETE : print("Delete OK!")
            //        case Business.OP_CANCEl : print("Cancel OK!")
            //        case Business.OP_INPUT : print("Input OK!")
            //        case Business.OP_MODIFY : print("Edit OK!")
        //        case Business.OP_DETAILS : print("Details OK!")
        default:
            print("〖\(querier!.name)〗OK!")
        }
    }
    func onFailed<T>(_ error: Int, _ msg: String, _ querier: Querier<T>?) {
        print("〖\(querier!.name)〗failled!")
    }
    
    /** add necessary information to querier for edit operation */
    func processEditQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }
    /** add necessary information to querier for input operation */
    func processInputQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }

    /** 删除 */
    func onCmdDelete() {entityPresenter?.delete(id, IListener(getSimpleOpView()))}
    /** 取消 */
    func onCmdCancel() {entityPresenter?.cancel(id, IListener(getSimpleOpView()))}
    /** 编辑UI */
    func onCmdInput() {
        if operation != 0 {entityPresenter?.operation = operation}
        entityPresenter?.input(id, IListener(getInputOpView()), IQuerierProcessor(getInputQuerierProcessor()))
    }
    /** 编辑 */
    func onCmdEdit() {
        if operation != 0 {entityPresenter?.operation = operation}
        entityPresenter?.edit(id, IListener(getSimpleOpView()), IQuerierProcessor(getEditQuerierProcessor()))
    }
    /** 详情 */
    func onCmdDetails() {entityPresenter?.details(id, IListener(getSimpleOpView()))}
    /** 执行某项操作 */
    func operate(_ operation : Int) {
        let o : OperationPresenter<E>? = entityPresenter?.findOperationPresenter(operation)
        o?.operate(id, IListener(getSimpleOpView()))
    }
    /** 执行某项操作 */
    func execute(_ operation : Int) {
        let o : Presenter<E>? = entityPresenter?.findPresenter(operation)
        o?.execute();
    }
    /** 执行某项操作 */
    func execute() {
        entityPresenter?.querierProcessor = IQuerierProcessor(getEditQuerierProcessor())
        entityPresenter?.execute();
    }

    //}}=======================common cross platforms===============================
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
    }

}
