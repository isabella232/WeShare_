//
//  UserDvo.swift
//  HLShare
//
//  Created by HLApple on 2017/12/25.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

// 用户Dvo
class UserDvo: HLBaseDvo {

    /** 用户名（自然键） */
    var  userId: String?
    
    /** 昵称 */
    var  nickname: String?
    
    /** 头像路径（不含主机部分） */
    var  avatarUri: String?
    
    /** 性别 */
    var  gender: String?
    
    /** 个人简介 */
    var  briefIntro: String?
    
    /** 手机号码 */
    var  mobile: String?
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
