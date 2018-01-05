//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: BaseNao<LoginDvo>{
    override init() {
        super.init()
        tokenAware = false
    }
    override func parseJson(_ json: String) -> Any? {
        return LoginDvo.deserialize(from: json)
    }
    static func loginQuerier(_ userId: String,_ password: String) -> Querier<LoginDvo> {
        let querier = Querier<LoginDvo>()
        querier.url = "/user/user!login"
        querier.params.updateValue(password, forKey: "password")
        querier.params.updateValue(userId, forKey: "userId")
        return querier
    }
}
class LoginPresenter: Presenter<LoginDvo> {
    override init() {
        super.init()
        nao = LoginNao()
    }
    func login(_ username : String , _ password : String , _ onSuccess : FnOnResponse<LoginDvo>? , _ onError : FnOnError<LoginDvo>) {
        execute(nao!, LoginNao.loginQuerier(username , password), onSuccess , nil)
    }

}

