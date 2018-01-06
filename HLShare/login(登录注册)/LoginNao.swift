//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: BaseEntityNao<LoginResult>{
    override init() {
        super.init()
        tokenAware = false
    }
    override func parseJson(_ json: String) -> Any? {
        return LoginResult.deserialize(from: json)
    }
    static func loginQuerier(_ userId: String,_ password: String) -> Querier<LoginResult> {
        let querier = Querier<LoginResult>()
        querier.url = "user/user!login"
        querier.params.updateValue(password, forKey: "password")
        querier.params.updateValue(userId, forKey: "userId")
        return querier
    }
}
class LoginPresenter: EntityPresenter<LoginResult> {
    override init() {
        super.init()
        nao = LoginNao()
    }
//    func login(_ username : String , _ password : String , _ onSuccess : FnOnResponse<LoginResult>? , _ onError : FnOnError<LoginResult>) {
//        execute(nao!, LoginNao.loginQuerier(username , password), onSuccess , nil)
//    }
    func login(_ username : String , _ password : String) {
        execute(nao!, LoginNao.loginQuerier(username , password), listener!)
    }
//    //login method 2
//    override var querier: Querier<LoginResult>? {return LoginNao.loginQuerier("", "")}
}

