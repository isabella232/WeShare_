//
//  HomeTableViewCell.swift
//  HLShare
//
//  Created by HLApple on 2017/12/26.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit



class HomeTableViewCell: UITableViewCell,UITextViewDelegate {
    
    

    @IBOutlet weak var contentTextView: UITextView!
    
    var user: HomeViewController.User!
    override func awakeFromNib() {
        selectionStyle = .none
        contentTextView.delegate = self
    }
    
    func link(str: String,subs: [String]) -> NSAttributedString {
        let content = NSMutableAttributedString(string: str)
        for sub in subs{
            if let index = str.positionOf(sub: sub){
                content.addAttribute(.link, value:"A://", range: NSRange(location: index, length: sub.count))
                content.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: index, length: sub.count))
            }
            content.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: str.count))
        }
        return content
    }
    
    var demand: Demand?{
        didSet{
            if let demand = demand {
                var op = ""
                let count = "已经有\(demand.badeProvisionCount ?? 0)人投标"
                if user == HomeViewController.User.lessor {
                    op = "修改_投标  举_报  投_标  撤_标" // 需求
                }else{
                    op = count + "  " + "删_除 举_报"
                }

                let str = """
                详情   需求
                ID:  \(demand.id!)
                发布者: \(demand.badeProvision?.provider?.name ?? "nil")
                标题: \(demand.name ?? "nil")
                描述: \(demand.content ?? "nil")
                位置: \(demand.longitude,demand.latitude)
                据我: \(demand.fromMe)
                价格: \(demand.price)
                状态: \(demand.badeProvision?.state ?? "nil")
                操作: \(op)
                """
                contentTextView.attributedText = link(str: str, subs: ["举_报","修改_投标","撤_标","投_标 ","删_除",count,demand.badeProvision?.provider?.name ?? demand.badeProvision?.provider?.mobile ?? "无名",demand.badeProvision?.provider?.name ?? "未知"])
            }
        }
    }
    
    var salesResult: saleItem?{
        didSet{
            var op = ""
            if user == HomeViewController.User.lease {
                op = "下_单  举_报" // 需求
            }else{
                op = "修_改  下_架  删_除"
            }
            if let sales = salesResult {
                let str = """
                ID:  \(sales.id!)
                供方: \(sales.vendor?.name ?? "nil")
                标题: \(sales.name ?? "nil")
                描述: \(sales.content ?? "nil")
                位置: \(sales.longitude,sales.latitude)
                据我: \(sales.fromMe)
                价格: \(sales.price)
                押金: \(sales.deposit)
                库存: \(sales.stockNum)
                状态: \(sales.state ?? "nil")
                操作: \(op)
                """
                 contentTextView.attributedText = link(str: str, subs: ["修_改","下_架","删_除","下_单","举_报"])
            }
        }
    }
    var orderResult: OrderDvo?{
        didSet{
            if let order = orderResult  {
                let str = """
                详情   我的订单
                ID:  \(order.id!)
                供方: \(order.vendor!.name!)
                需方: \(order.buyer!.name!)
                名称: \(order.name!)
                描述: \(order.item!.saleItem!.content ?? "")
                位置: \(order.item!.saleItem!.latitude!)
                应付: \(order.due)
                实付: \(order.paid)
                状态: \(order.state!)
                操作: \(order.canPay() ? " 付款 " : "")  \(order.canCancel() ? " 取消 " : "已取消")  \(order.item!.canReview() ? "| 评价 " : "") \(order.canUser() ? "开始使用 " : "")
                """
                contentTextView.attributedText = link(str: str, subs: ["详情"," 付款 "," 取消 "," 评价 ","开始使用",order.vendor!.name ?? order.vendor!.mobile ?? "无名",order.buyer!.name ?? "未知"])
            }
        }
    }
    
    
    
    
}




