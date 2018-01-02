//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: Nao{
    static func login(_ userId: String,_ password: String) -> LoginQuerier {
        let querier = LoginQuerier()
        querier.url = "/user/user!login"
        querier.param = ["userId":userId,"password":password]
        return querier
    }
}

class LoginQuerier: Querier {

}

class LoginListener: Listener {

    override func success(_ dev: Result) {
        print("--------success------------")
     }

    override func failure(_ code: Int, _ msg: String) {
        print("--------error------------")

    }
}

class LoginPresenter: Presenter {
    func login(userId: String,password: String) {
        execute(nao: LoginNao(), querier: LoginNao.login(userId, password), listener: LoginListener(),json: LoginModel.self)
    }
}

