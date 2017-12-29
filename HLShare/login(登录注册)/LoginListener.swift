//
//  LoginListener.swift
//  HLShare
//
//  Created by HLApple on 2017/12/29.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit




class LoginListener: OnResponse {

    
    func success(_ dev: Result) {
        print("login --------------")
    }
    
    
    func failure(_ code: Int, _ msg: String) {
        print("login  failure--------------")

    }
}
