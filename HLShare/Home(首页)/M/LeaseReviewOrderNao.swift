//
//  LeaseReviewOrderNao.swift
//  HLShare
//
//  Created by HLApple on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit


class LeaseReviewOrderNao: Nao {
    
    static let share = LeaseReviewOrderNao()
    
    override init() {
        super.init()
        baseUrl = "/lease/reviewOrder"
    }
    
    ///获取 评价订单信息
    ///
    /// - Parameters:
    ///   - targetId: 被评价的订单项ID（新建时使用，建议修改时不使用）
    ///   - id: 评价的ID（仅当修改时使用)
    ///   - role: 用户角色参数取值：1-供给方/卖家，2-需求方/买家。
    ///   - score: 评分。5分制
    ///   - content: 评价的内容
    static func reviewOrderInputQuerier(_ targetId: Int, _ role: Int)->Querier<Result>{
        let q = Querier<Result>()
        q.url = "!input"
        q.desc = "评价成功啦"
        q.param.updateValue(targetId, forKey: "targetId")
        q.param.updateValue(role, forKey: "role")
        return q
    }
    
    /// 同上
    /// 提交评价
    static func reviewOrderQuerier(_ targetId: Int, _ role: Int, score: Int, content: String)->Querier<Result>{
        let q = Querier<Result>()
        q.param.updateValue(targetId, forKey: "targetId")
        q.param.updateValue(role, forKey: "role")
        q.param.updateValue(score, forKey: "score")
        q.param.updateValue(content, forKey: "content")
        q.desc = "提交成功"
        return q
    }
    
}

// 评价订单
class LeaseReviewOrderPresneter: Presenter {
    
}
