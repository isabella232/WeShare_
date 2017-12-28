//
//  HomeModel.swift
//  HLShare
//
//  Created by HLApple on 2017/12/25.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit


/// 需求方业务管理



/// 列出需求
class DemandsResult: Result{
    
    var demands: [Demand]?
    
    /** 总记录 */
    var totalRecords: Int?
   
    /** 开始位置 */
    var pageStart: Int?
    
    /** 结束位置 */
    var pageStop: Int?
    
    required init() {}
    
    class Demand: HLPoiDvo {
        
        var fileDvos: [FileDvo]?
        
        var badeProvision: badeProvision?

        /** 需求价格 */
        var price: Float?
        
        /** （当前用户作为需方时）投标的数量 */
        var badeProvisionCount: Int?
        
        required init() {}
        
        class FileDvo: HLBaseDvo {
            /**文件路径 */
            var filePath: String?
            required init() {}

        }
        
        class badeProvision: HLBaseDvo {
            var saleItem: saleItem?
            required init() {}
            
            class saleItem: HLPoiDvo {
                /** 好评率 */
                var  averageScore: Double?
                
                /** 价格 */
                var  price: Float?
                
                /** 押金 */
                var  deposit: Float?
                
                /** 库存 */
                var  stockNum: Int?
                
                /** 付款方式 */
                var  payMode: Int?
                
                /** 卖家 */
                //public String lessorId;
                var  vendor: UserDvo?
                
                var fileDvos:[FileDvo]?
                
                required init() {
                    super.init()
                }
            }
        }
    }
}


