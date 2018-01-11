//
//  InputLeaseReviewOrderController.swift
//  HLShare
//
//  Created by HLApple on 2018/1/4.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class InputLeaseReviewOrderController: EntityView<Result, Result> {
    
    @IBOutlet weak var orderInfoLabel: UILabel! // 订单信息
    @IBOutlet weak var descTextField: UITextField! // 描述
    @IBOutlet weak var scoreTextField: UITextField! // 评分
    
    var presenter =  ReviewOrderPresenter()
    override var entityPresenter: EntityPresenter<Result>? {return presenter}
    
    override func commonInit() {
        presenter.querierProcessor = IQuerierProcessor(getEditQuerierProcessor())
        super.commonInit()
    }
    
    //var targetId: Int! // 订单的id
    
    @IBAction func done(_ sender: UIButton) {
//        presenter.execute(LeaseReviewOrderNao.reviewOrderQuerier(targetId, 2, score: Int(scoreTextField.text!)!, content: descTextField.text!))
        
        presenter.review(id, 2, 4, "asdsfsdfsdf", IListener(getSimpleOpView()))
        //onCmdEdit()
    }
    
    override func processInputQuerier<T>(_ querier: Querier<T>) {
        querier.params["role"] = 2
        OperationNao<T>.processInputQuerier(id, querier)
    }
    
//    override func processEditQuerier<T>(_ querier: Querier<T>) {
//        processInputQuerier(querier)
//        querier.params["score"] = 5
//        querier.params["content"] = "okokokok"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "评价"
        
//        presenter.execute(LeaseReviewOrderNao.reviewOrderInputQuerier(targetId,2), success: { (model) in
//
//        }, failure: { (code, msg) in
//
//        })
        id = 10
        onCmdInput()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onOperated<T>(_ response: T, _ querier: Querier<T>?) {
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
