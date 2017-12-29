//
//  HLBaseNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

/// 全局变量  登录的token
var app_request_token: String?


protocol GeneratorType {
    associatedtype Element
    mutating func next() -> Element?
}
protocol SequenceType {
    associatedtype Generator : GeneratorType
    func generate() -> Generator
}


extension SequenceType{
    
    func execute(gen: Generator){
    
    }
}






protocol Result {

}




protocol Listener {

    associatedtype R

    func success(_ dev: R) -> Void

    func failure(_ code: Int,_ msg: String) -> Void
}




protocol Presenter {

    typealias NaoAssociated = Nao
    typealias QuerierAssociated = Querier
    typealias ListenerAssociated = Listener

//    var nao: N { get }
//
//    var querier: Q { get }
//
//    var listener: L { get }
}

extension Presenter{

    
    func execute(nao: NaoAssociated, querier: QuerierAssociated,listener: ListenerAssociated){
        nao.excute(querier: querier)
    }

    func execute() {
       // execute(nao: nao, querier: querier, listener: listener)
    }
}


protocol Querier {
    
    associatedtype ListenerAssociated: Listener
    
    var url: String { get set }
    
    var param: [String: Any] { get set }
    
    var listener: ListenerAssociated { get set }
    
}

protocol Nao {
    associatedtype QuerierAssociated: Querier
}



extension Nao {
     func excute(querier: QuerierAssociated) {
        var param = querier.param
        param.updateValue("true", forKey: "silent")
        if let t = app_request_token {
            param.updateValue(t, forKey: "token")
        }

//        HLNetworkManager.POST(url: BASEURL + netQuerier.url, param: netQuerier.param,listener: netQuerier.listener)
    }
}
































