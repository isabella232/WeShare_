//
//  Business.swift
//  HLShare
//
//  Created by HLApple on 2018/1/5.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class Business {
	
	/** 操作界面标识 */
	static let OP_UI = 0x10000000
	
    //操作标志位
    //通用操作一（范围：最后1个字节）
    /** 创建 */
    static let  OP_CREATE = 0x0001
    /** 修改 */
    static let OP_MODIFY = 0x0002
    /** 列表显示 */
    static let OP_LIST = 0x0004
    /** 显示详情 */
    static let OP_DETAILS = 0x0008
    /** 删除 */
    static let OP_DELETE = 0x0010
    /** 取消 */
    static let OP_CANCEL = 0x0020
    /**  */
    static let OP_INPUT = 0x0040
    /** 创建关联实体 */
    static let OP_CREATE_RELATED = 0x0080
    
    //通用操作二（范围：右起第2个字节）
    /** 点赞 */
    static let OP_LIKE = 0x0100
    /** 评论/回复 */
    static let OP_REPLY = 0x0200
    /** 收藏 */
    static let OP_FAVOR = 0x0400
    static let OP_REVIEW = 0x0800
    /** 举报 */
    static let OP_REPORT = 0x1000
    /** 审核 */
    static let OP_CENSOR = 0x2000
    
    //{{用户操作
    /** 加为好友 */
    static let OP_MAKE_FRIEND = 0x010000
    /** 成为好友（仅用于操作状态标志） */
    static let OPS_IS_FRIEND = 0x020000
    //}}
    
    //{{好友关系
    /** 指向我的关系/我发出的关系 */
    static let OPS_POINT_TO_ME = 0x010000
    //}}
    
    //{{订单&订单项
    //卖家（供方）订单操作（范围：右起第3个字节-后半段）
    /** 结束处理 */
    static let OP_ORDER_FINISH = 0x010000
    /** 改款 */
    static let OP_ORDER_CHANGE_PAYMENT = 0x020000
    //卖家订单项操作：评价（OP_REVIEW）
    //买家（需方）订单操作：修改（OP_MODIFY），取消（OP_CANCEL），其他（范围：右起第3个字节-前半段）
    /** 付款 */
    static let OP_ORDER_PAY = 0x100000
    /** 开始使用 */
    static let OP_ORDER_BEGIN = 0x200000
    /** 结算确认 */
    static let OP_ORDER_CONFIRM_SETTLE = 0x400000
    //买家订单项操作：评价（OP_REVIEW）
    //}}
    
    //{{销售项（关联实体：←订单）
    //卖家（供方）可能的操作：修改（OP_MODIFY），删除（OP_DELETE），其他（范围：右起第3个字节-后半段）
    /** 上架 */
    static let OP_SALE_SHELVE_ON = 0x010000
    /** 下架 */
    static let OP_SALE_SHELVE_OFF = 0x020000
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
    static let OP_PROVISION_ACCEPT_BID = 0x100000
    /** 定标 */
    static let OP_PROVISION_CONFIRM_BID = 0x200000
    //}}
}
