//
//  NetworkManager.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON

typealias failureBlock = (WeShareError)->Void
typealias successBlock<R> = (_ res: R)->Void


enum WeShareError: Swift.Error{
    case DataNull
    case DeserializeFail
    case NetworkFail(Error)
    case ResponseFail(code: Int,msg: String?)
}
extension WeShareError{
    var desc: String{
        switch self {
        case .DataNull:
            return "关键数据为空"
        case .DeserializeFail:
            return "数据解析失败!"
        case .NetworkFail(let error):
//            return "网络连接失败, 请检查网络设置."
            return "error: \(error)"
        case .ResponseFail( _,let message):
            return message ?? "服务器没有返回描述"
        }
    }
}


protocol NetworkCompletionHandler {
    associatedtype Value: Result
    func failure(_ error: WeShareError)
    func success(_ response: Value)
}


class JNao{
    var baseUrl = ""
    var baseParam = [String: Any]()
    var needToken: Bool = true
    
    var showMsg = ""
    
    init(_ url: String) {self.baseUrl = url}
    
    func processQuerier<R>(querier: JQuerier<R>) -> JQuerier<R> {
        
        querier.url = baseUrl + querier.url
        
        if needToken {
            querier.params.updateValue(Config.token, forKey: "token")
        }
        
        for (key,value) in baseParam{
            querier.params.updateValue(value, forKey: key)
        }
        
        if let pager = querier.pager {
            pager.fill(&querier.params)
        }
        
        return querier
    }
    
    /// 代理
    func execute<R>(_ querier: JQuerier<R>){
        NetworkManager.POST(querier)
    }
    
    
    
}
class JQuerier<R: Result>:NetworkCompletionHandler{
    func failure(_ error: WeShareError) {failure?(error)}
    func success(_ response: R) {success?(response)}
    
    typealias Value = R
    
    
    var operation_id: Int = Business.OP_LIST
    
    var url: String = ""
    
    var params: [String: Any] = ["silent": "true"]
    
    var headers: [String: String]? = nil
    
    var success: successBlock<R>?
    
    var failure: failureBlock?
    
    var pager: Pager?
    
    // 默认为空字符串
    init(_ url: String = "") {self.url = url}
}


class JBasePresenter<R: Result>{
    /// 查询器 默认查询器 没有参数没有地址
    var querier = JQuerier<R>("")
    
    /// 默认nao 没有地址
    var nao: JNao = JNao("")
    
    /// 分页器
    /// 提供下拉加载更多功能
    /// 默认 0页 1条数据
    var pager: Pager = Pager(0, 1)

    
    /// 代理方式执行回调
    func execute(){
        nao.execute(querier)
    }
    
    /// 闭包方式执行回调
    func execute<T>(_ querier: JQuerier<T>){
        nao.execute(querier)
    }
}

class JPresenterListController<Element: Dvo,R: ListResult<Element>>:
JPresenterBaseViewController<R>,
UITableViewDataSource,
UITableViewDelegate
{
    
    var tableView: UITableView!
    
    // 重用标识符 约定: 重用标识符必须和cell 名字一样
    // 子类需要重写此属性
    var cellIdentifier: String{return "cell"}
    
    /// 数据源
    var dataSource = [Element]()
    
    /** 刷新  true 表示  下拉刷新  false加载更多*/
    var refresh: Bool = true{
        didSet{
            /// 如果刷新一次, 把分页页器页数归0
            if refresh {
                presenter.pager.page = 0
            }
        }
    }
    
    override func failure(_ error: WeShareError) {
        super.failure(error)
        self.tableView.es.stopPullToRefresh(ignoreDate: true)
        self.tableView.es.stopLoadingMore()
    }
    
    override func success(_ response: R) {
        super.success(response)
        if let list = response.entities {
            if refresh{
                self.dataSource = list
                self.tableView.reloadData()
            }else{
                /// 计算行数
                var indexs = [IndexPath]()
                for i in  0 ..< list.count {
                    let index = IndexPath(row: i + dataSource.count, section: 0)
                    print("index: \(index)")
                    
                    indexs.append(index)
                }
                /// 添加数据
                self.dataSource.append(contentsOf: list)
                /// 刷新指定的行数
                self.tableView.insertRows(at: indexs, with: .automatic)
            }
        }
        
        self.tableView.es.stopPullToRefresh(ignoreDate: true)
        self.tableView.es.stopLoadingMore()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    /// 代理方式执行回调
    override func execute() {
        /// 分页器
        presenter.querier.pager = presenter.pager
        presenter.pager.increase()
        super.execute()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.es.addPullToRefresh {[weak self] in
            self?.refresh = true
            self?.execute()
        }
        tableView.es.addInfiniteScrolling {[weak self] in
            self?.refresh = false
            self?.execute()
        }
    }
    
}

class JPresenterBaseViewController<R: Result>: UIViewController{
    
    var presenter: JBasePresenter<R>{return JBasePresenter<R>()}
    
    /// 代理方式执行回调
    func execute() {
        presenter.querier.success = {[weak self] result in
            self?.success(result)
        }
        presenter.querier.failure = {[weak self] error in
            self?.failure(error)
        }
        presenter.execute()
    }
    
    /// 执行回调
    func execute<T>(_ querier: JQuerier<T>){
        querier.success = {[weak self] result in
            self?.op_success(result)
        }
        querier.failure = {[weak self] error in
            self?.op_failure(error)
        }
        presenter.execute(querier)
    }
    
    func failure(_ error: WeShareError) {
        print("*****************failure presenter**************************")
    }
    
    func success(_ response: R) {
        print("*****************successs presenter**************************")
    }
    
    func op_failure(_ error: WeShareError) {
        print("*****************failure presenter**************************")
    }
    
    func op_success(_ response: Result) {
        print("*****************successs presenter**************************")
    }
}

class NetworkManager<R: Result> {
    
    static func POST(_ querier: JQuerier<R>){
        
        print("url: \(querier.url)")
        print("params",querier.params)
        Alamofire.request(Config.BASE_URL + querier.url,
                          method: .post,
                          parameters: querier.params,
                          headers: querier.headers).responseJSON{ (response) in
                            print("json: \(JSON(response.result.value ?? "josn 为空"))")
                            switch response.result{
                            case .success( _):
                                if let data = response.data {
                                    if let model = R.deserialize(from: String(data: data, encoding: .utf8)){
                                        if model.error == 0{
                                            /// 如果token变化 就把token 及时更新
                                            if let token = model.token{Config.token = token}
                                            querier.success(model)
                                            
                                        }else{
                                            let error = WeShareError.ResponseFail(code: model.error, msg: model.desc)
                                            querier.failure(error)
                                        }
                                    }else{
                                        querier.failure(WeShareError.DeserializeFail)
                                    }
                                }else{
                                    querier.failure(WeShareError.DataNull)
                                }
                            case .failure(let error ):
                                print("error: \(error)")
                                querier.failure(WeShareError.NetworkFail(error))
                            }
        }
    }
}







