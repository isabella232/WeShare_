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
        case lessor
        case lease
    }
    /// 列表
    @IBOutlet weak var homeTableView: UITableView!
    
    
    
    /* 供给方 **/
    var lessor: DemandsResult?
    
    /* 需求方 **/
    var lease: DemandsResult?
    
    // 默认显示供给方
    var user: User = .lessor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.rowHeight = 300
        
        
        /* 查找需求方列表**/
        LessorNao.share.listDemand(success: {[unowned self] (result) in
            self.lessor = result
            self.homeTableView.reloadData()
        }) { (code, msg) in
            
        }
        
        /* 查找供给方列表**/
        LeaseNao.share.listDemand(success: {[unowned self] (result) in
            self.lease = result
        }) { (code, msg) in
            
        }
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user == .lessor {
            return self.lessor?.demands?.count ?? 0
        }else{
            return self.lease?.demands?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        if user == .lessor {
            cell.demand = self.lessor?.demands?[indexPath.row]
        }else{
            cell.demand = self.lease?.demands?[indexPath.row]
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
        case .censor:
            print(123)
            print(123)

        case .report:
            print(123)
            print(123)

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
    
 
    
    /// 供求与需求 切换
    /// - Parameter sender:
    @IBAction func changed(_ sender: UIBarButtonItem) {
        ActionSheet.show(hint: "提示", msgs: ["供给方","需求方","地图","列表视图","搜索","我的投标"], finished: { (index, title) in
            print(index,title)
        }) {
            
        }
    }  
    
}

