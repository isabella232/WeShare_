//
//  BaseViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/27.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

extension SwiftNoticeProtocol where Self: UIViewController{
    func errorHandle(error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
protocol SwiftNoticeProtocol{
    func errorHandle(error: String)
}


class BaseViewController<R:Result,E:Result>: UIViewController {
    
    // 带分页器
    //var presenter = PagerPresenter()

    var tableView: UITableView? = nil
    
    var model: R? = nil
    
    var pager: Pager? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       

    }
    
//    func getDataSource() {
//        presenter.execute(Querier<R>(), success: {[unowned self] (result) in
//            self.model = result
//            self.tableView?.reloadData()
//        }) { (code, msg) in
//
//        }
//    }
    
    
    func operatorion(pid: Int,result: E, _ cell: UITableViewCell)  {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


