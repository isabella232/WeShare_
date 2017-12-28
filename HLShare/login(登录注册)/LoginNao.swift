//
//  LoginNao.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class LoginNao: HLBaseNao{
    
    static let share = LoginNao()
    /// 登录
    ///
    /// - Returns: <#return value description#>
    static func login(_ userId: String,_ password: String) -> HLBaseQuerier {
        let querier = HLBaseQuerier()
        querier.url = "/user/user!login"
        querier.param = ["userId":userId,"password":password]
        return querier
    }
}
