//
//  LoginPresenter.swift
//  HLShare
//
//  Created by HLApple on 2017/12/28.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginPresenter: HLBasePresenter<LoginListener> {
    
    override var listener: HLBaseListener?{
        return LoginListener()
    }

    
    /// 登录
    ///
    /// - Parameters:
    ///   - userId: 用户名
    ///   - password: 密码
    ///   - success: 成功
    ///   - failure: 失败
    func login(userId: String,password: String) {
        execute(nao: LoginNao.share, querier: LoginNao.login(userId, password), listener: listener!)
    }
    
   
    
   
}
