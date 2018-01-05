//
//  InputLeaseReviewOrderController.swift
//  HLShare
//
//  Created by HLApple on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class InputLeaseReviewOrderController: ComboView<Result, Result, Result> {
    
    @IBOutlet weak var orderInfoLabel: UILabel! // 订单信息
    @IBOutlet weak var descTextField: UITextField! // 描述
    @IBOutlet weak var scoreTextField: UITextField! // 评分
    
    var presenter =  ReviewOrderPresenter()
    
    var targetId: Int! // 订单的id
    
    @IBAction func done(_ sender: UIButton) {
//        presenter.execute(LeaseReviewOrderNao.reviewOrderQuerier(targetId, 2, score: Int(scoreTextField.text!)!, content: descTextField.text!))
        presenter.operate(targetId, IListener(getSimpleOpView()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "评价"
        
//        presenter.execute(LeaseReviewOrderNao.reviewOrderInputQuerier(targetId,2), success: { (model) in
//
//        }, failure: { (code, msg) in
//
//        })
        
        onCmdInput()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func simpleOperate<T>(_ response: T, _ querier: Querier<T>?) {
        print("review ok")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
