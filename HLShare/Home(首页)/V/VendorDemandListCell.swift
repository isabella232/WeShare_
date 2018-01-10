//
//  VendorDemandListCell.swift
//  HLShare
//
//  Created by HLApple on 2018/1/10.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

protocol ListLeaseOrdersProtocol: NSObjectProtocol {
    func leaseOrderOperation(operation: OrderOperation,order: Demand,_ cell: UITableViewCell)
}

class VendorDemandListCell: UITableViewCell {

    @IBOutlet weak var contentTextView: UITextView!
    weak var delegate: ListLeaseOrdersProtocol?

    var entity: Demand?{
        didSet{
            if let demand = entity {
                let op = "修改_投标  举_报  投_标  撤_标" // 需求
                let count = "已经有\(demand.badeProvisionCount ?? 0)人投标"
                let str = """
                详情   需求
                ID:  \(demand.id!)
                发布者: \(demand.badeProvision?.provider?.name ?? "nil")
                标题: \(demand.name ?? "nil")
                描述: \(demand.content ?? "nil")
                位置: \(demand.longitude,demand.latitude)
                据我: \(demand.fromMe ?? 0)
                价格: \(demand.price ?? 0)
                状态: \(demand.badeProvision?.state ?? "nil")
                操作: \(op)
                """
                contentTextView.attributedText = link(str: str, subs: ["举_报","修改_投标","撤_标","投_标 ","删_除",count,demand.badeProvision?.provider?.name ?? demand.badeProvision?.provider?.mobile ?? "无名",demand.badeProvision?.provider?.name ?? "未知"])
            }
        }
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
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let start = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location)
        let end = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location + characterRange.length)
        
        
        if  textView.text[start..<end] == VendorDemandListCell.OP_DEL_TENDER {
            delegate?.leaseOrderOperation(operation: .delete,order: entity!, self)
        }
        if  textView.text[start..<end] == VendorDemandListCell.OP_REPORT {
            delegate?.leaseOrderOperation(operation: .report,order: entity!, self)
        }
        if  textView.text[start..<end]  == VendorDemandListCell.OP_TENDER {
            delegate?.leaseOrderOperation(operation: .input,order: entity!, self)
        }
        if  textView.text[start..<end]  == VendorDemandListCell.OP_FIX_TENDER {
            delegate?.leaseOrderOperation(operation: .input,order: entity!, self)
        }
        if  textView.text[start..<end]  == VendorDemandListCell.OP_DEL_TENDER {
            delegate?.leaseOrderOperation(operation: .delete,order: entity!, self)
        }
        return false
    }
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let OP_REPORT = "举_报"
    static let OP_TENDER = "投_标"
    static let OP_FIX_TENDER = "修改_投标"
    static let OP_DEL_TENDER = "撤_标"
    static let OP_DELETE = "删_除"
    static let OP_RELATED = "下_单"
    static let OP_SALE_OFF = "下_架"
    static let OP_SALE_ON = "上_架"
    static let OP_PAY = "付_款"
    static let OP_CANCEL = "取_消"
    static let OP_CANCELED = "已取_消"
    static let OP_REVIEW = "评_价"
    static let OP_START_USE = "开始_使用"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
