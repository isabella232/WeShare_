//
//  LoginViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
//import HyphenateLite
class LoginViewController: EntityView<LoginResult, LoginResult> {

    var presenter = LoginPresenter()
    override var entityPresenter: EntityPresenter<LoginResult>? {return presenter as EntityPresenter<LoginResult>}
    
//    override func commonInit() {
//        super.commonInit()
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
    /// 用户登录
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func userLogin(_ sender: UIButton) {
//        presenter.login("aaaaaa", "111111", { (result, querier) in
//            //            EMClient.shared().login(withUsername:model.easemobUserName , password: model.easemobPassword, completion: { (userName, error) in
//            //                if error != nil{
//            //                    print("--------登录成功---------")
//            //                }else{
//            //                    print("--------登录失败---------")
//            //                }
//            //            })
//            UIApplication.shared.keyWindow?.rootViewController =  self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar")
//        }, { (code, msg, querier) in
//
//        })
        presenter.login("aaaaaa", "111111")
        //login method 2
        //execute()
    }
    
//    //login method 2
//    override func processEditQuerier<T>(_ querier: Querier<T>) {
//        querier.params["userId"] = "aaaaaa"
//        querier.params["password"] = "111111"
//    }
    
    override func onOperated<T>(_ response: T, _ querier: Querier<T>?) {
        UIApplication.shared.keyWindow?.rootViewController =  self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
