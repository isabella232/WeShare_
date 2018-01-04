//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: Nao{
    static func loginQuerier(_ userId: String,_ password: String) -> Querier<LoginDvo> {
        let querier = Querier<LoginDvo>()
        querier.url = "/user/user!login"
        querier.param.updateValue(password, forKey: "password")
        querier.param.updateValue(userId, forKey: "userId")
        return querier
    }
}
class LoginPresenter: Presenter {
    override init() {
        super.init()
        nao = LoginNao()
    }

}

