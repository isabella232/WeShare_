//
//  HomeTableViewCell.swift
//  HLShare
//
//  Created by HLApple on 2017/12/26.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

protocol ListLeaseOrdersProtocol: NSObjectProtocol {
    func leaseOrderOperation(operation: OrderOperation,order: DemandsResult.Demand,_ cell: UITableViewCell)
}


class HomeTableViewCell: UITableViewCell,UITextViewDelegate {
    

    @IBOutlet weak var contentTextView: UITextView!
    
    weak var delegate: ListLeaseOrdersProtocol?
    
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
    
    var demand: DemandsResult.Demand?{
        didSet{
            if let demand = demand {
                let str = """
                ID:  \(demand.id!)
                发布者: \(demand.badeProvision?.provider?.name ?? "nil")
                标题: \(demand.name ?? "nil")
                描述: \(demand.content ?? "nil")
                位置: \(demand.longitude,demand.latitude)
                据我: \(demand.fromMe)
                价格: \(demand.price)
                状态: \(demand.badeProvision?.state ?? "nil")
                操作: \(demand.didReport() ? "举报" : "-举-")  \(demand.canCensor() ? "审核" : "-审-")  \(demand.canTender() ? "| 投标" : "-标-") \(demand.canModify() ? "修改投标" : "-修-") \(demand.canRemove() ? "撤标" : "-撤-")
                """
                contentTextView.attributedText = link(str: str, subs: ["举报","审核","修改投标","撤标","投标 ",demand.badeProvision?.provider?.name ?? demand.badeProvision?.provider?.mobile ?? "无名",demand.badeProvision?.provider?.name ?? "未知"])
            }
            
            
        }
        
           
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let start = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location)
        let end = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location + characterRange.length)
        
        if  textView.text[start..<end] == "举报" {
            delegate?.leaseOrderOperation(operation: .report,order: demand!, self)
        }
        if  textView.text[start..<end]  == "审核" {
            delegate?.leaseOrderOperation(operation: .censor,order: demand!, self)
        }
        if  textView.text[start..<end]  == "投标" {
            delegate?.leaseOrderOperation(operation: .input,order: demand!, self)
        }
        if  textView.text[start..<end]  == "修改投标" {
            delegate?.leaseOrderOperation(operation: .input,order: demand!, self)
        }
        if  textView.text[start..<end]  == "撤标" {
            delegate?.leaseOrderOperation(operation: .delete,order: demand!, self)
        }
        if  String(textView.text[start..<end])  == demand!.badeProvision!.provider!.name {
            delegate?.leaseOrderOperation(operation: .lookupVendor,order: demand!, self)
        }
        return false
    }
    
}


//var order: ListLeaseOrdersResult.LeaseOrderDvo!{
//    didSet{
//        let str = """
//        详情
//        ID:  \(order.id!)
//        供方: \(order.vendor!.name!)
//        需方: \(order.buyer!.name!)
//        名称: \(order.name!)
//        描述: \(order.item!.saleItem!.content ?? "")
//        位置: \(order.item!.saleItem!.latitude!)
//        应付: \(order.due)
//        实付: \(order.paid)
//        状态: \(order.state!)
//        操作: \(order.canPay() ? " 付款 " : "")  \(order.canCancel() ? " 取消 " : "已取消")  \(order.item!.canReview() ? "| 评价 " : "") \(order.canUser() ? "开始使用 " : "")
//        """
//        contentTextView.attributedText = link(str: str, subs: ["详情"," 付款 "," 取消 "," 评价 ","开始使用",order.vendor!.name ?? order.vendor!.mobile ?? "无名",order.buyer!.name ?? "未知"])
//    }
//}

