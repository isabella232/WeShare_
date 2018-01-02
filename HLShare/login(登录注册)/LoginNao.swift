//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: Nao{
    static func loginQuerier(_ userId: String,_ password: String) -> Querier {
        let querier = Querier()
        querier.url = "/user/user!login"
        querier.param.updateValue(password, forKey: "password")
        querier.param.updateValue(userId, forKey: "userId")
        return querier
    }
}
class LoginPresenter: Presenter {
    func login(userId: String,password: String,success: @escaping successBlock,failure: @escaping failureBlock) {
        execute(nao: LoginNao(), querier: LoginNao.loginQuerier(userId, password), Result: LoginDvo.self, success: success, failure: failure)
    }
}

