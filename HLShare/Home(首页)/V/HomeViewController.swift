//
//  ViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/21.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import HandyJSON
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    /// 列表
    @IBOutlet weak var homeTableView: UITableView!
    
    // 修改投标
    @IBAction func clickTenderEdit(_ sender: UIButton) {
        print(msg: "修改投标")

        let cell =  sender.superview?.superview as! HomeTableViewCell
        let row = homeTableView.indexPath(for: cell)?.row
        let demand = self.demandsModel!.demands![row!]
//        presenter.tenderEdit(id: demand.id, success: { (dvo) in
//            sender.setTitle("已修改", for: .normal)
//        }) { (code, msg) in
//
//        }
    }
    // 投标
    @IBAction func clickTender(_ sender: UIButton) {
        print(msg: "投标")
        let cell =  sender.superview?.superview as! HomeTableViewCell
        let row = homeTableView.indexPath(for: cell)?.row
        let demand = self.demandsModel!.demands![row!]
        
        // 能投标
//        if demand.canTender() {
//            presenter.tender( demandId: demand.id!, success: { (dvo) in
//                sender.setTitle("已投标", for: .normal)
//            }, failure: { (code, msg) in
//
//            })
//        }
        
       
        
        
    }
    var presenter = HomePresenter()
    
    // 返回的数据模型
    var demandsModel: DemandsResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.rowHeight = 500
        
//        presenter.getBuyerOrder(success: {[unowned self] (dvo) in
//            let demands =  dvo as! DemandsResult
//            self.demandsModel = demands
//            self.homeTableView.reloadData()
//        }) { (code, msg) in
//            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        
        if let model = self.demandsModel {
            
            
            cell.contentLabel.text =
            """
            id: \(model.demands![indexPath.row].id!)
            name: \(model.demands![indexPath.row].name!)
            modifyTime: \(model.demands![indexPath.row].modifyTime!)
            fromMe: \(model.demands![indexPath.row].fromMe!)
            content: \(model.demands![indexPath.row].content!)
            latitude: \(model.demands![indexPath.row].latitude!)
            longitude: \(model.demands![indexPath.row].longitude!)
            createTime: \(model.demands![indexPath.row].createTime!)
            price: \(model.demands![indexPath.row].price)
            canMove: \(model.demands![indexPath.row].canOrder())
            fileDvos.filePath: \(model.demands![indexPath.row].fileDvos?.first?.filePath! ?? "空 path")
            """
            
            if model.demands![indexPath.row].canTender(){
                cell.tenderBtn.setTitle("投标", for: .normal)
            }else{
                cell.tenderBtn.setTitle("已投标", for: .normal)
            }
            
            if model.demands![indexPath.row].canModify(){
                cell.tenderEditBtn.setTitle("修改投标", for: .normal)
            }else{
                cell.tenderEditBtn.setTitle("已修改投标", for: .normal)
            }
            
            
            
        }

       
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

