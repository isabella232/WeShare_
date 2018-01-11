//
//  InputleseeOrderController.swift
//  HLShare
//
//  Created by HLApple on 2018/1/3.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class InputleseeOrderController: ComboView<Result, Result, Result> {

    var saleItemId: Int? = nil
    var presenter = EditOrderPresenter()
    var model: LesseeOrderInputResult? = nil
    @IBAction func editLesseeOrder(_ sender: UIButton) {
        
//        presenter.execute(LesseeOrderNao.getEditLesseeOrderQuerier(model!.saleItem!.id!, model!.saleItem!.payMode!))
        onCmdEdit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        presenter.execute(LesseeOrderNao.getLesseeOrderInputQuerier(saleItemId!), success: { (result) in
//
//        }) { (code, msg) in
//
//        }
        onCmdInput()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
