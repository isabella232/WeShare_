//
//  results.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation
import HandyJSON

class Result: HandyJSON {
    var error: Int!
    var desc: String?
    var token: String?
    required init() {}
}

class ListResult<E> : Result {
	var getEntities: [E]? {return nil}
	required init(){}
}
