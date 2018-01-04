//
//  InputleseeOrderController.swift
//  HLShare
//
//  Created by HLApple on 2018/1/3.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

class InputleseeOrderController: UIViewController {

    var saleItemId: Int? = nil
    var presenter = LesseeOrderPresenter()
    var model: LesseeOrderInputResult? = nil
    @IBAction func editLesseeOrder(_ sender: UIButton) {
        
        presenter.execute(LesseeOrderNao.getEditLesseeOrderQuerier(model!.saleItem!.id!, model!.saleItem!.payMode!))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.execute(LesseeOrderNao.getLesseeOrderInputQuerier(saleItemId!), success: { (result) in
            
        }) { (code, msg) in
            
        }
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
