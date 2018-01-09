//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: GNao<LoginResult>{
    static func loginQuerier(_ userId: String,_ password: String) -> GQuerier<LoginResult> {
        let querier = GQuerier<LoginResult>("!login")
        querier.params.updateValue(password, forKey: "password")
        querier.params.updateValue(userId, forKey: "userId")
        return querier
    }
}
class LoginPresenter: GPresenter<LoginResult> {
    override init() {
        super.init()
        self.nao = LoginNao(url: "user/user")
    }
    func login(_ username : String , _ password : String) {
        execute(nao: nao!, querier: LoginNao.loginQuerier(username, password))
    }

}

