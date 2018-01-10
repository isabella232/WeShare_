//
//  ViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/21.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import HandyJSON

class HomeViewController : UIViewController,ListLeaseOrdersProtocol {
    
    /* 使用方 **/
    enum User{
        case lessor // 供给方
        case lease  // 需求
    }
    enum Servies {
        case forTenderDemand // 我的投标需求
        case forSale   // 销售
        case forMineOrder   // 我的订单
        case none
    }
    
    

    // 默认显示供给方
    var user: User = .lessor
    var service: Servies = .none

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vendorVC = self.storyboard?.instantiateViewController(withIdentifier: "VendorDemandListController") as! VendorDemandListController
        self.view.addSubview(vendorVC.view)
        self.addChildViewController(vendorVC)
    }
    
 
    func leaseOrderOperation(operation: OrderOperation, order: Demand, _ cell: UITableViewCell) {
        switch operation {
        case .input:
            let provision = self.storyboard?.instantiateViewController(withIdentifier: "ProvisionInputController") as! ProvisionInputController
            provision.hidesBottomBarWhenPushed = true
            provision.orderId = order.id!
            navigationController?.pushViewController(provision, animated: true)
        case .report:
            let input = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
            input.hidesBottomBarWhenPushed = true
            input.id = order.id!
            navigationController?.pushViewController(input, animated: true)
        case .delete:
            if self.user == .lessor{
                // 撤标
                LessorOperationNao.share.delete(id: order.id!, success: { (result) in
                    SwiftNotice.showNoticeWithText(text: "撤标成功")
                }, failure: { (code, msg) in
                    SwiftNotice.showNoticeWithText(text: "撤标失败: \(msg)")
                })
            }else{
                LeaseOperationNao.share.delete(id: order.id!, success: { (result) in
                    SwiftNotice.showNoticeWithText(text: "删除我的需求")
                }, failure: { (code, msg) in
                    SwiftNotice.showNoticeWithText(text: "删除失败: \(msg)")
                })
            }
        default:
            print(123)
            print(123)
        }
   }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 供求与需求 切换 **/
    @IBAction func changedUser(_ sender: UIBarButtonItem) {
        ActionSheet.show(hint: "", msgs: ["供给方","需求方"], finished: {[unowned self](index, title) in
            if title == "供给方"{
                
            }else {
                
            }
            self.title = title
        })
    }
    
    
    /// - Parameter sender:
    @IBAction func changed(_ sender: UIBarButtonItem) {
        var title = ""
        var arr = [String]()
        if user == .lessor{
            title = "供给方"
            arr = ["地图","列表视图","搜索","我的投标需求","列出销售项","我的订单"]
        }else{
            title = "需求方"
            arr = ["地图","列表视图","搜索","列出销售项","我的订单"]
        }
        ActionSheet.show(hint: title, msgs: arr, finished: { (index, title) in
            self.title = title

            switch title{
            case "地图":
                print("")
                print("")
                
            case "列表视图":
                print("")
                print("")
            case "搜索":
                print("")
                print("")
            case "我的投标需求":
                print("")
                print("")
            case "列出销售项":
                if self.user == .lessor{
                    
                }else{
                  
                }
            case "我的订单":
                if self.user == .lessor{
                   
                }else{
                   
                }
            default:
                print("")
            }
        })
    }
}

