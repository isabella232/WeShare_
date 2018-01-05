//
//  BaseViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

extension SwiftNoticeProtocol where Self: UIViewController{
    func errorHandle(error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
protocol SwiftNoticeProtocol{
    func errorHandle(error: String)
}


class BaseViewController<R:Result,E:Result>: UIViewController {
    
    // 带分页器
    //var presenter = PagerPresenter()

    var tableView: UITableView? = nil
    
    var model: R? = nil
    
    var pager: Pager? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       

    }
    
//    func getDataSource() {
//        presenter.execute(Querier<R>(), success: {[unowned self] (result) in
//            self.model = result
//            self.tableView?.reloadData()
//        }) { (code, msg) in
//
//        }
//    }
    
    
    func operatorion(pid: Int,result: E, _ cell: UITableViewCell)  {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}

/**
 * 组合视图。内含对实体的操作，以及对实体列表的操作。
 * @param <E> 实体/元素操作返回类型
 * @param <L> 列表操作返回类型
 * @param <I> input操作返回类型
 * @author BraveLu
 */
class ComboView<E, L, I> : UIViewController {
    
//{{=======================don't change===============================
    /** base "inner class" for callbacks */
    class InnerOpView<T, E, L, I> : OpViewEx<T> {
        var outer : ComboView<E, L, I>
        init(_ outer : ComboView<E, L, I>) {
            self.outer = outer
            super.init()
        }
    }
    /** list operation callback */
    class ListView<L> : InnerOpView<L, E, L, I> {
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
    /** any other operations callback */
    class SimpleOpView<T> : InnerOpView<T, E, L, I> {
        override var operationName : String {return "\(outer.entityName)"}
        override func show(_ response: T , _ querier : Querier<T>?) {
            super.show(response , querier)
            outer.simpleOperate(response , querier)
        }
    }
    /** querier processor for edit operation */
    class EditQuerierProcessor<T> : PQuerierProcessor {
        typealias R = T
        var outer : ComboView<E, L, I>
        init(_ outer : ComboView<E, L, I>) {self.outer = outer}
        func processQuerier(_ querier : Querier<R>) -> Querier<R> {
            outer.processEditQuerier(querier)
            return querier
        }
    }
    /** querier processor for input operation */
    class InputQuerierProcessor<T> : PQuerierProcessor {
        typealias R = I
        var outer : ComboView<E, L, I>
        init(_ outer : ComboView<E, L, I>) {self.outer = outer}
        func processQuerier(_ querier : Querier<R>) -> Querier<R> {
            outer.processInputQuerier(querier)
            return querier
        }
    }
    
    /** the final callback for list operation */
    func showList(_ response : L) {
        print("Please show the list here.")
    }
    /** the final callback for other operations */
    func simpleOperate<T>(_ response : T , _ querier : Querier<T>?) {
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
    /** add necessary information to querier for edit operation */
    func processEditQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }
    /** add necessary information to querier for input operation */
    func processInputQuerier<T>(_ querier : Querier<T>) {
        // put processing codes here in subclasses
    }
    /** 实体类型名称 */
    var entityName : String = "实体"
    var operation = 0
    /** 组合Presenter */
    var comboPresenter : ComboPresenter<E, L>?
    var entityPresenter : EntityPresenter<E>? {return comboPresenter?.entityPresenter}
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        listView = ListView<L>(self)
        //simpleOpView = SimpleOpView<E>(self)
        //inputOpView = SimpleOpView<I>(self)
        //editQuerierProcessor = EditQuerierProcessor(self)
        //inputQuerierProcessor = InputQuerierProcessor(self)
        comboPresenter = createComboPresenter()
        //listView.operationName = "获取\(entityName)列表"
    }


  
    /** 分页器 */
    var pager : Pager? = nil
    /** 列表操作视图 */
    //    var listView : OpView<L> = OpView<L>()
    //    {
    //        override var operationName {return "获取\(entityName)列表"}
    //    };
    var listView : ListView<L>? = nil
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
    func doCmdOperate(_ operation : Int) {
        let o : OperationPresenter<E>? = comboPresenter?.findOperationPresenter(operation)
        o?.operate(id, IListener(getSimpleOpView()))
    }
//}}=======================don't change===============================
    

    
    
}


