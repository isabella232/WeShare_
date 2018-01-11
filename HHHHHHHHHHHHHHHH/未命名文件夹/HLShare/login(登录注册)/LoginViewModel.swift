//
//  LoginDvo.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Dispatch

class LoginResult : Result {
    required init() {}
    /// 环信用户名
    var easemobUserName: String?
    /// 环信登录密码
    var easemobPassword: String?
   
}

class LoginViewModel{

    var valiteUsername: Observable<Bool>
    
    var valitePassword: Observable<Bool>
    
    var loginEnable: Observable<Bool>
    
   // var login: Observable<Bool>

    init(username: Observable<String>,code: Observable<String>,tap:Observable<Void>) {
        print("----------- init --------------")

        valiteUsername = username.map({ text in
            
            print("userName: \(text)")
            
            return true
        }).share(replay: 1)
        
        valitePassword = code.map({ text in
            
            print("password: \(text)")
            
            return true
        }).share(replay: 1)
        
        loginEnable = Observable.combineLatest(valiteUsername,valitePassword){($0,$1)}.share(replay: 1).map({ (x,y)  in
            return x&&y
        }).share(replay: 1)
        
        let usernameApassword  = Observable.combineLatest(username,code){($0,$1)}
        
        //NetworkManager.POST(querier: GQuerier("user/user!login"))

        
//        login = tap
//            .withLatestFrom(usernameApassword)
//            .flatMapLatest({ user in
////                var querier = GQuerier("user/user!login")
////                querier.params.updateValue(password, forKey: "password")
////                querier.params.updateValue(userId, forKey: "userId")
////                var ob = NetworkManager.POST(querier: querier).map({ (result)  in
////                    return true
////                }).catchErrorJustReturn(false)
//                print("user: \(user))")
//                return Observable.just(true)
//            })
       
        }
    

        
    
    
}


