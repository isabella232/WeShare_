//
//  HLBaseDvo.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import HandyJSON

class Dvo : HandyJSON {
    
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
    
    /** 分页 */
    var totalRecords: Int?
    var pageStop: Int?
    var pageStart: Int?

    
    required init(){}
    
    /** 能否修改？ */
    func canModify() ->Bool{
        return ((Business.OP_MODIFY & operations!) != 0);
    }
    /** 能否删除？ */
    func canRemove() ->Bool{
        return ((Business.OP_DELETE & operations!) != 0);
    }
    /** 能否评价？ */
    func canReview() ->Bool{
        return ((Business.OP_REVIEW & operations!) != 0);
    }
    /** 能否点赞？ */
    func canLike() ->Bool{
        return ((Business.OP_LIKE & operations!) != 0);
    }
    /** 能否评论/回复？ */
    func canReply() ->Bool{
        return ((Business.OP_REPLY & operations!) != 0);
    }
  
    //是否进行了如下操作
    /** 是否修改？ */
    func didModify() ->Bool{
        return ((Business.OP_MODIFY & operated!) != 0);
    }
    /** 是否删除？ */
    func didRemove() ->Bool{
        return ((Business.OP_DELETE & operated!) != 0);
    }
    /** 是否评价？ */
    func didReview() ->Bool{
        return ((Business.OP_REVIEW & operated!) != 0);
    }
    /** 是否点赞？ */
    func didLike() ->Bool{
        return ((Business.OP_LIKE & operated!) != 0);
    }
    /** 是否评论/回复？ */
    func didReply() ->Bool{
        return ((Business.OP_REPLY & operated!) != 0);
    }
    /** 是否收藏/关注？ */
    func didFavor() ->Bool{
        return ((Business.OP_FAVOR & operated!) != 0);
    }
    /** 是否举报？ */
    func didReport() ->String{
        return ((Business.OP_REPORT & operated!) != 0) ? "举报" : "NO举"
    }
    
    /** 能否举报？ */
    func canReport() -> String {
        return ((Business.OP_REPORT & operations!) != 0) ? "举报" : ""
    }
    
    
    /** 能否付款 */
    func canPay() ->Bool{
        return ((Business.OP_ORDER_PAY & operations!) != 0);
    }
    /** 能否投标 */
    func canTender() ->String{
        return ((Business.OP_CREATE_RELATED & operations!) != 0) ? "投标" : ""
    }
    /** 能否取消 */
    func canCancel() -> Bool {
        return ((Business.OP_CANCEL & operations!) != 0);
    }
    
    /** 能否开始使用 */
    func canUser() -> Bool {
        return ((Business.OP_ORDER_BEGIN & operations!) != 0);
    }
    

    
}

class PoiDvo: Dvo {
    /** 经度 */
    var longitude: Double?
    
    /** 纬度 */
    var latitude: Double?
    
    /** 距离 */
    var fromMe: Double?
    
    /** 位置标题 */
    var place: String?
}

// 用户Dvo
class UserDvo: Dvo {
    
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
    
    required init() {}
}


class saleItem: PoiDvo {
    /** 好评率 */
    var averageScore: Double?
    
    /** 价格 */
    var price: Float?
    
    /** 押金 */
    var deposit: Float?
    
    /** 库存 */
    var stockNum: Int?
    
    /** 付款方式 */
    var payMode: Int?
    
    /** 卖家 */
    //public String lessorId;
    var vendor: UserDvo?
    
    var fileDvos:[FileDvo]?
    
    required init() {}
    
    
}

class FileDvo: Dvo {
    /**文件路径 */
    var filePath: String?
    required init() {}
}
