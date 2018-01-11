//
//  StringTool.swift
//  HLShare
//
//  Created by HLApple on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

extension String {
    func positionOf(sub:String)->Int? {
        if let range = range(of:sub),!range.isEmpty {
            return characters.distance(from:startIndex, to:range.lowerBound)
        }
        return nil
    }
}
