//
//  VendorDemandListController.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class VendorDemandListController: UITableViewController,ResponseHandelProtocol {
    
    
    typealias Value = DemandsResult
    
    var presenter = VendorDemandListPresenter()
    
    var demand: DemandsResult?
    
    let CELL_REUSABLE_IDENFIFIER = "vendorDemandList"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.execute()
    }
    
    func successHandle(_ response: DemandsResult, _ operation: Int) {
            self.demand = response
            self.tableView.reloadData()
    }
    
    func failureHandle(_ error: Int, _ msg: String, _ operation: Int) {
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demand?.demands?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSABLE_IDENFIFIER, for: indexPath) as! VendorDemandListCell
        if let entitys = demand?.demands {cell.entity = entitys[indexPath.row]}
        return cell
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
