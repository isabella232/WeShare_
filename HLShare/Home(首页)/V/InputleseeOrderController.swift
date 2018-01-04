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
    var presenter: LesseeOrderPresenter? = nil
    var model: LesseeOrderInputResult? = nil
    @IBAction func editLesseeOrder(_ sender: UIButton) {
        
        presenter?.editLesseeOrder(model!.saleItem!.id!, model!.saleItem!.payMode!, success: { (result) in
            
        }, failure: { (code, msg) in
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getLesseeOrderInput(saleItemId: saleItemId!, success: {[unowned self] (dvo) in
            
        }, failure: { (code, msg) in
            
        })
       
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
