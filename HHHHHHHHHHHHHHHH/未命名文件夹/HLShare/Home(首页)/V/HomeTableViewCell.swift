//
//  HomeTableViewCell.swift
//  HLShare
//
//  Created by HLApple on 2017/12/26.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

protocol ListLeaseOrdersProtocol: NSObjectProtocol {
    func leaseOrderOperation(operation: OrderOperation,order: LeaseOrderDvo,_ cell: UITableViewCell)
}

enum OrderOperation {
    case lookupDetails
    case lookupVendor
    case lookupBuyer
    case pay
    case cancel
    case review
    case startUse
}
/**
*/
class HomeTableViewCell: /*UITableViewCell*/TableComboViewCell<LeaseOrderDvo>,UITextViewDelegate {
	

	override var entity: LeaseOrderDvo? {
		get {return order}
		set {order = newValue}
	}

    @IBOutlet weak var contentTextView: UITextView!
    
    var nav: UINavigationController!
    
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
    
    var order: LeaseOrderDvo!{
        didSet{
            let str = """
            详情
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
	
	func onClickPay() {doOperate(Business.OP_ORDER_PAY)}
	func onClickBegin() {doOperate(Business.OP_ORDER_BEGIN)}
	func onClickFinish() {doOperate(Business.OP_ORDER_FINISH)}
			
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let start = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location)
        let end = textView.text.index(textView.text.startIndex, offsetBy: characterRange.location + characterRange.length)
        if textView.text[start..<end] == "详情" {
            print("------详情---------")
            //delegate?.leaseOrderOperation(operation: .lookupDetails,order: order, self)
			onClickDetails()
        }
        
        if  textView.text[start..<end] == " 付款 " {
            print("------付款---------")
            //delegate?.leaseOrderOperation(operation: .pay,order: order, self)
			onClickPay()
        }
        if  textView.text[start..<end]  == " 取消 " {
            print("------取消---------")
            onClickCancel()
        }
		if  textView.text[start..<end]  == " delete " {
			print("------delete---------")
			onClickDelete()
		}
        if  textView.text[start..<end]  == " 评价 " {
            print("------评价---------")
            //delegate?.leaseOrderOperation(operation: .review,order: order, self)
			onClickReviewUi()
        }
        if  textView.text[start..<end]  == "开始使用" {
            print("------开始使用---------")
           // delegate?.leaseOrderOperation(operation: .startUse,order: order, self)
			onClickBegin()
        }
        
//        if  String(textView.text[start..<end])  == order.vendor!.name {
//            print("------供方 姓名---------")
//            delegate?.leaseOrderOperation(operation: .lookupVendor,order: order, self)
//        }
//
//        if  String(textView.text[start..<end])  == order.vendor!.mobile {
//            print("------供方 手机---------")
//            delegate?.leaseOrderOperation(operation: .lookupVendor,order: order, self)
//
//        }
//
//        if  String(textView.text[start..<end])  == order.buyer!.name {
//            print("------需方姓名---------")
//            delegate?.leaseOrderOperation(operation: .lookupBuyer,order: order, self)
//        }
        return false
	}
		
}
