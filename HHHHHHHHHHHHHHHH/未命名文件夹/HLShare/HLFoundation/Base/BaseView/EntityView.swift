//
//  BaseView.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

//import Foundation
import UIKit

/**
* 实体视图，内含对实体的操作。
* @param <E> 实体/元素操作返回类型
* @param <I> input操作返回类型
* @author BraveLu
*/
class EntityView<E, I> : UIViewController {
    
    //{{=======================common cross platforms===============================
	
	/** 普通实体操作基类 */
    class InnerEntityOpView<T, E, I> : OpViewEx<T> {
        var outer : EntityView<E, I>
        init(_ outer : EntityView<E, I>) {
            self.outer = outer
            super.init()
        }
    }
    /** 普通操作的简单回调 */
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
    /** 针对Edit操作的查询器加工器 */
    class EditQuerierProcessor<T> : PQuerierProcessor {
        typealias R = T
        var outer : EntityView<E, I>
        init(_ outer : EntityView<E, I>) {self.outer = outer}
        func processQuerier(_ querier : Querier<R>) -> Querier<R> {
            outer.processEditQuerier(querier)
            return querier
        }
    }
    /** 针对Input操作的查询器加工器 */
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
	/** 当前Presenter本身代表的操作。非0值时才有意义。 */
    var operation = 0
    /** 绑定的实体Presenter。由子类提供。 */
    var entityPresenter : EntityPresenter<E>? {return nil}
    
    /** 简单操作的回调视图 */
    //var simpleOpView : SimpleOpView<E>? = nil
    func getSimpleOpView() -> SimpleOpView<E> {return SimpleOpView<E>(self)}
	
	/** 输入操作的回调视图 */
	//var inputOpView : SimpleOpView<I>? = nil
    func getInputOpView() -> SimpleOpView<I> {return SimpleOpView<I>(self)}
	
	/** 编辑操作的查询加工器 */
    //var editQuerierProcessor : EditQuerierProcessor<E>? = nil
    func getEditQuerierProcessor() -> EditQuerierProcessor<E> {return EditQuerierProcessor<E>(self)}
	
	/** 输入操作的查询加工器 */
	//var inputQuerierProcessor : InputQuerierProcessor<I>? = nil
    func getInputQuerierProcessor() -> InputQuerierProcessor<I> {return InputQuerierProcessor<I>(self)}
	
    //    /** 取消视图 */
    //    protected OpView<E> m_cancelView=new OpView<E>() {
    //    @Override public String getOperationName() {return "取消"+m_entityName;}
    //    };
    
    //控件变量
    /** 当前操作的实体ID */
    var id = 0
    //var targetId = 0

	/** 公共构造方法 */
    func commonInit() {
        entityPresenter?.listener = IListener(getSimpleOpView())
    }

    /** 当普通操作成功时最终的回调处理 */
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
	
	/** 当普通操作失败最终的回调处理 */
    func onFailed<T>(_ error: Int, _ msg: String, _ querier: Querier<T>?) {
        print("〖\(querier!.name)〗failled!")
    }
    
    /** 编辑操作时，对查询器进行加工 */
    func processEditQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }
	
    /** 输入操作时，对查询器进行加工 */
    func processInputQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }

    /** 删除 */
    func onCmdDelete() {entityPresenter?.delete(id, IListener(getSimpleOpView()))}
    /** 取消 */
    func onCmdCancel() {entityPresenter?.cancel(id, IListener(getSimpleOpView()))}
    /** 输入，即为编辑提供UI */
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
	
    /** 执行某项Operation类型的操作（根据操作编号从Presenter组内获取）
	 * @return 是否已执行
	 */
    func operate(_ operation : Int) -> Bool {
        if let o : OperationPresenter<E> = entityPresenter?.findOperationPresenter(operation) {
			o.operate(id, IListener(getSimpleOpView()))
			return true
		}
		return false
    }
    /** 执行某项操作（根据操作编号从Presenter组内获取）
	 * @return 是否已执行
	 */
    func execute(_ operation : Int) -> Bool {
		if let o : Presenter<E> = entityPresenter?.findPresenter(operation) {
			o.execute()
			return true
		}
		return false
    }
    /** 自身执行默认操作 */
    func execute() {
        entityPresenter?.querierProcessor = IQuerierProcessor(getEditQuerierProcessor())
        entityPresenter?.execute()
    }
	/** 自身执行某项指定操作
	 * @return 是否已执行
	 */
	func selfExecute(_ operation : Int) -> Bool {
		print("执行编号为\(operation)的操作")
		switch operation {
		case Business.OP_DELETE: onCmdDelete()
		case Business.OP_CANCEL: onCmdCancel()
		case Business.OP_INPUT: onCmdInput()
		case Business.OP_MODIFY: onCmdEdit()
		case Business.OP_DETAILS: onCmdDetails()
		default: return false
		}
		return true
	}

    //}}=======================common cross platforms===============================
	
//以下为iOS平台特定部分
	
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
