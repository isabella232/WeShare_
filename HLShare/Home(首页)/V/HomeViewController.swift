//
//  ViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/21.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import HandyJSON

class HomeViewController : UIViewController,UITableViewDataSource,UITableViewDelegate,ListLeaseOrdersProtocol {
  
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
    /// 列表
    @IBOutlet weak var homeTableView: UITableView!
    
    /*  数据源 **/
    var result: DemandsResult?
    var salesResult: saleItemsResult?
    var orderResult: OrdersResult?

    // 默认显示供给方
    var user: User = .lessor
    var service: Servies = .none

    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.rowHeight = 300
        
        // 默认 供给方
        changedUser(UIBarButtonItem())
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch service {
        case .forSale:
            return salesResult?.saleItems?.count ?? 0
        case .forMineOrder:
            return orderResult?.orders?.count ?? 0
        default:
            return self.result?.demands?.count ?? 0
        }
    }
      
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        cell.user = user
        switch service {
        case .forSale:
            cell.salesResult = salesResult?.saleItems?[indexPath.row]
        case .forMineOrder:
            cell.orderResult = orderResult?.orders?[indexPath.row]
        default:
            cell.demand = result?.demands?[indexPath.row]
        }
        return cell
    }
    
    
 
    func leaseOrderOperation(operation: OrderOperation, order: DemandsResult.Demand, _ cell: UITableViewCell) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 供求与需求 切换 **/
    @IBAction func changedUser(_ sender: UIBarButtonItem) {
        ActionSheet.show(hint: "", msgs: ["供给方","需求方"], finished: {[unowned self](index, title) in
            if title == "供给方"{
                /* 查找需求方列表**/
                LessorNao.share.listDemand(success: {[unowned self] (result) in
                    self.result = result
                    self.user = .lessor
                    self.homeTableView.reloadData()
                }) { (code, msg) in
                    
                }
            }else {
                /* 查找供给方列表**/
                LeaseNao.share.listDemand(success: {[unowned self] (result) in
                    self.result = result
                    self.user = .lease
                    self.homeTableView.reloadData()
                }) { (code, msg) in
                    
                }
            }
            self.title = title
            self.homeTableView.reloadData()
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
                LessorNao.share.listForTender(success: {[unowned self] (result) in
                    self.result = result
                    self.service = .forTenderDemand
                    self.homeTableView.reloadData()
                    }, failure: { (code, msg) in
                        
                })
            case "列出销售项":
                if self.user == .lessor{
                    LessorNao.share.listForSale(success: { (result) in
                        self.salesResult = result
                        self.service = .forSale
                        self.homeTableView.reloadData()
                    }, failure: { (code, msg) in
                        
                    })
                }else{
                    LeaseNao.share.listForSale(success: { (result) in
                        self.salesResult = result
                        self.service = .forSale
                        self.homeTableView.reloadData()
                    }, failure: { (code, msg) in
                        
                    })
                }
            case "我的订单":
                if self.user == .lessor{
                    LessorNao.share.listForOrder(success: { (result) in
                        self.orderResult = result
                        self.service = .forMineOrder
                        self.homeTableView.reloadData()
                    }, failure: { (code, msg) in
                        
                    })
                }else{
                    LeaseNao.share.listForOrder(success: { (result) in
                        self.orderResult = result
                        self.service = .forMineOrder
                        self.homeTableView.reloadData()
                    }, failure: { (code, msg) in
                        
                    })
                }
            default:
                print("")
            }
        })
    }
}

