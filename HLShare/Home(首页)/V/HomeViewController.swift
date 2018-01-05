//
//  ViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/21.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import HandyJSON


class HomeViewController : BuyerOrderView,UITableViewDataSource,UITableViewDelegate {
    
  
    
 
    
    
    
    override func showList(_ response: ListLeaseOrdersResult) {
        self.demandsModel = response
        self.homeTableView.reloadData()
    }

//    // 租方订单列表
//    var presenter = LesseeOrderPresenter()

    /// 列表
    @IBOutlet weak var homeTableView: UITableView!
    
    // 返回的数据模型
    var demandsModel: ListLeaseOrdersResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.rowHeight = 300
        
//        presenter.execute(LesseeOrderNao.getLesseeOrderQuerier(), success: {[unowned self] (result) in
//            self.demandsModel = result
//            self.homeTableView.reloadData()
//        }) { (code, msg) in
//
//        }
        
        onCmdList()
 
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let model = self.demandsModel {
//            return model.orders!.count
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        //cell.delegate = self
//        if let model = self.demandsModel {
//            let order = model.orders![indexPath.row]
//            cell.order = order
//        }
//        
        return cell
        
    }
    
//    func leaseOrderOperation(operation: OrderOperation, order: ListLeaseOrdersResult.LeaseOrderDvo, _ cell: UITableViewCell) {
//        switch operation {
//
//        case .cancel:
//            presenter.execute(LesseeOrderNao.cancelQuerier(order.id!), success: { (result) in
//
//            }, failure: { (code, msg) in
//
//            })
//
//        case .review:
//            let input = self.storyboard?.instantiateViewController(withIdentifier: "InputLeaseReviewOrderController") as! InputLeaseReviewOrderController
//            input.hidesBottomBarWhenPushed = true
//            input.targetId = order.id!
//            self.navigationController?.pushViewController(input, animated: true)
//        case .lookupBuyer:
//            print(123)
//            print(123)
//
//        case .lookupVendor:
//            print(123)
//            print(123)
//
//        case .lookupDetails:
//            print(123)
//            print(123)
//
//        case .startUse:
//            presenter.execute(LesseeOrderNao.beginQuerier(order.id!), success: { (result) in
//
//            }, failure: { (code, msg) in
//
//            })
//
//        case .pay:
//            print(123)
//            print(123)
//
//        default:
//            print(123)
//            print(123)
//
//        }
//    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let orders = self.demandsModel!.orders {
//            let saleItemId = orders[indexPath.row].item!.saleItem!.id!
//            let input = self.storyboard?.instantiateViewController(withIdentifier: "InputleseeOrderController") as! InputleseeOrderController
//            input.saleItemId = saleItemId
//            input.presenter = presenter
//            input.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(input, animated: true)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    // 修改投标
    @IBAction func clickTenderEdit(_ sender: UIButton) {
        print(msg: "删除")
        
        
        let cell =  sender.superview?.superview as! HomeTableViewCell
        let row = homeTableView.indexPath(for: cell)?.row
        let demand = self.demandsModel!.orders![row!]
        //        presenter.tenderEdit(id: demand.id, success: { (dvo) in
        //            sender.setTitle("已修改", for: .normal)
        //        }) { (code, msg) in
        //
        //        }
    }
    // 投标
    @IBAction func clickTender(_ sender: UIButton) {
        print(msg: "修改")
        let cell =  sender.superview?.superview as! HomeTableViewCell
        let row = homeTableView.indexPath(for: cell)?.row
        let demand = self.demandsModel!.orders![row!]
        
        // 能投标
        //        if demand.canTender() {
        //            presenter.tender( demandId: demand.id!, success: { (dvo) in
        //                sender.setTitle("已投标", for: .normal)
        //            }, failure: { (code, msg) in
        //
        //            })
        //        }
    }
    
    /// 供求与需求 切换
    ///
    /// - Parameter sender:
    @IBAction func changedDemandSide(_ sender: UISegmentedControl) {
        
    }
    
    /// 地图与列表 切换
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func chnagedMapView(_ sender: UIBarButtonItem) {
        
    }
    
}

