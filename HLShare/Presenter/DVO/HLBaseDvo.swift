//
//  HLBaseDvo.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

//操作标志位
//通用操作一（范围：最后1个字节）
/** 创建 */
let  OP_CREATE = 0x0001
/** 修改 */
let OP_MODIFY = 0x0002
/** 列表显示 */
let OP_LIST = 0x0004
/** 显示详情 */
let OP_DETAILS = 0x0008
/** 删除 */
let OP_DELETE = 0x0010
/** 取消 */
let OP_CANCEL = 0x0020
/** 评价 */
let OP_REVIEW = 0x0040
/** 创建关联实体 */
let OP_CREATE_RELATED = 0x0080

//通用操作二（范围：右起第2个字节）
/** 点赞 */
let OP_LIKE = 0x0100
/** 评论/回复 */
let OP_REPLY = 0x0200
/** 收藏 */
let OP_FAVOR = 0x0400
/** 举报 */
let OP_REPORT = 0x1000
/** 审核 */
let OP_CENSOR = 0x2000

//{{用户操作
/** 加为好友 */
let OP_MAKE_FRIEND = 0x010000
/** 成为好友（仅用于操作状态标志） */
let OPS_IS_FRIEND = 0x020000
//}}

//{{好友关系
/** 指向我的关系/我发出的关系 */
let OPS_POINT_TO_ME = 0x010000
//}}

//{{订单&订单项
//卖家（供方）订单操作（范围：右起第3个字节-后半段）
/** 结束处理 */
let OP_ORDER_FINISH = 0x010000
/** 改款 */
let OP_ORDER_CHANGE_PAYMENT = 0x020000
//卖家订单项操作：评价（OP_REVIEW）
//买家（需方）订单操作：修改（OP_MODIFY），取消（OP_CANCEL），其他（范围：右起第3个字节-前半段）
/** 付款 */
let OP_ORDER_PAY = 0x100000
/** 开始使用 */
let OP_ORDER_BEGIN = 0x200000
/** 结算确认 */
let OP_ORDER_CONFIRM_SETTLE = 0x400000
//买家订单项操作：评价（OP_REVIEW）
//}}

//{{销售项（关联实体：←订单）
//卖家（供方）可能的操作：修改（OP_MODIFY），删除（OP_DELETE），其他（范围：右起第3个字节-后半段）
/** 上架 */
let OP_SALE_SHELVE_ON = 0x010000
/** 下架 */
let OP_SALE_SHELVE_OFF = 0x020000
//买家（需方）可能的操作：下单（OP_CREATE_RELATED）
//}}

//{{需求（关联实体：←供给）
//供方可能的操作：投标（OP_CREATE_RELATED）
//需方可能的操作：发布（OP_CREATE），修改（OP_MODIFY），删除（OP_DELETE）
//}}

//{{供给
//供方操作：修改投标（OP_MODIFY），撤标（OP_DELETE）
//需方操作（范围：右起第3个字节-前半段）
/** 选标 */
let OP_PROVISION_ACCEPT_BID = 0x100000
/** 定标 */
let OP_PROVISION_CONFIRM_BID = 0x200000
//}}

class HLBaseDvo: Result {
    
    /** 实体ID（代理键） */
    var id: Int?

    /** 創建時間 */
    var createTime: String?

    /** 修改时间 */
    var modifyTime: String?

    /** 自然键（如果有） */
    //public Object getNatureId() ->Bool{return null;}

    /** 名称/标题 */
    var name: String?

    /** 描述/内容 */
    var content: String?

    /** 状态（供显示用的名称） */
    var state: String?
    
    /** 允许的操作。取值： {@link Business#OP_MODIFY} 等，按位组合。 */
    var operations: Int?
    
    /** 已经进行过的操作。取值： {@link Business#OP_MODIFY} 等，按位组合。 */
    var operated: Int?
    
    /** 类型标识 */
    var type: String?
    
    required init(){}
    
    /** 能否修改？ */
    func canModify() ->Bool{
        return ((OP_MODIFY & operations!) != 0);
    }
    /** 能否删除？ */
    func canRemove() ->Bool{
        return ((OP_DELETE & operations!) != 0);
    }
    /** 能否评价？ */
    func canReview() ->Bool{
        return ((OP_REVIEW & operations!) != 0);
    }
    /** 能否点赞？ */
    func canLike() ->Bool{
        return ((OP_LIKE & operations!) != 0);
    }
    /** 能否评论/回复？ */
    func canReply() ->Bool{
        return ((OP_REPLY & operations!) != 0);
    }
    /** 能否举报？ */
    func canReport() ->Bool{
        return ((OP_REPORT & operations!) != 0);
    }
    //是否进行了如下操作
    /** 是否修改？ */
    func didModify() ->Bool{
        return ((OP_MODIFY & operated!) != 0);
    }
    /** 是否删除？ */
    func didRemove() ->Bool{
        return ((OP_DELETE & operated!) != 0);
    }
    /** 是否评价？ */
    func didReview() ->Bool{
        return ((OP_REVIEW & operated!) != 0);
    }
    /** 是否点赞？ */
    func didLike() ->Bool{
        return ((OP_LIKE & operated!) != 0);
    }
    /** 是否评论/回复？ */
    func didReply() ->Bool{
        return ((OP_REPLY & operated!) != 0);
    }
    /** 是否收藏/关注？ */
    func didFavor() ->Bool{
        return ((OP_FAVOR & operated!) != 0);
    }
    /** 是否举报？ */
    func didReport() ->Bool{
        return ((OP_REPORT & operated!) != 0);
    }
    
    /** 能否下单 */
    func canOrder() ->Bool{
        return ((OP_CREATE_RELATED & operations!) != 0);
    }
    
    /** 能否投标 */
    func canTender() ->Bool{
        return ((OP_CREATE_RELATED & operations!) != 0);
    }

}
