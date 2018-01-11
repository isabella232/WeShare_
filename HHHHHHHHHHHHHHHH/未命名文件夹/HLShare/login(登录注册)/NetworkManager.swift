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
import RxSwift
import RxCocoa

typealias failureBlock = (Int?,String)->Void
typealias successBlock<R> = (R)->Void


enum WeShareError: Swift.Error{
    case DataNull(msg: String)
    case DeserializeFail(msg: String)
    case NetworkFail(msg: String)
    case ResponseFail(code: Int,msg: String?)

}

class GQuerier {
    
    var url: String = ""
    
    var params: [String: Any] =  ["silent": "true","token": Config.token]
    
    var headers: [String: String]? = nil
    
    init(_ url: String) {self.url = url}
}


class NetworkManager<R: Result>{
    
    static func POST(querier: GQuerier)->Observable<Result> {
        
        return Observable<Result>.create { (observer) -> Disposable in
            
            Alamofire.request(Config.BASE_URL + querier.url,
                              method: .post,
                              parameters: querier.params,
                              headers: querier.headers).responseJSON{ (response) in
                                
                                switch response.result{
                                case .success( _):
                                    if let data = response.data {
                                        
                                        if let model = Result.deserialize(from: String(data: data, encoding: .utf8)){
                                            if model.error == 0{
                                                /// 如果token变化 就把token 及时更新
                                                if let token = model.token{Config.token = token}
                                                observer.onNext(model)
                                                observer.onCompleted()
                                            }else{
                                                observer.onError(WeShareError.ResponseFail(code: model.error, msg: model.desc))
                                            }
                                        }else{
                                            observer.onError(WeShareError.DeserializeFail(msg: "数据解析失败!"))

                                        }
                                    }else{
                                        observer.onError(WeShareError.DataNull(msg: "关键数据为空"))
                                    }
                                case .failure(let error ):
                                    print("error: \(error)")
                                    observer.onError(WeShareError.NetworkFail(msg: "网络连接失败, 请检查网络设置."))
                                }
            }
            
            return Disposables.create {
                
            }
            
        }
        
    }

}







