//
//  LoginViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
//import HyphenateLite
class LoginViewController: UIViewController {

    var presenter = LoginPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    /// 用户登录
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func userLogin(_ sender: UIButton) {
        presenter.login(userId: "aaaaaa", password: "111111", success: { (dvo) in
            
//            EMClient.shared().login(withUsername:model.easemobUserName , password: model.easemobPassword, completion: { (userName, error) in
//                if error != nil{
//                    print("--------登录成功---------")
//                }else{
//                    print("--------登录失败---------")
//                }
//            })
            UIApplication.shared.keyWindow?.rootViewController =  self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar")
        }) { (code, msg) in
            
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
