//
//  LessorDemandController.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit


class BuyerDemandListController: UITableViewController {
  

    var presenter = BuyerDemandListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.execute()
        
       
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
