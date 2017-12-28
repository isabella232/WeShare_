//
//  HLBaseQuerier.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class HLBaseQuerier: NSObject {

    var url: String!
    var param: [String: Any]!
    var listener: HLBaseListener!
    override init() {super.init()}
}
