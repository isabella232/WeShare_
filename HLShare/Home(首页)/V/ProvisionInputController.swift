//
//  ProvisionInputController.swift
//  HLShare
//
//  Created by HLApple on 2018/1/6.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class ProvisionInputController: UIViewController {

    /// 投标
    @IBAction func tender(_ sender: UIButton) {
    }
    
    @IBOutlet weak var demandInfo: UILabel!
    
    @IBOutlet weak var tenderInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProvisionNao.share.input(id: orderId, success: { (result) in
            
        }) { (code, msg) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
