//
//  RegisterViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func userRegister(_ sender: UIButton) {
//        NetworkManager.POST(url: "/user/user!register", param: ["userInfo.mobile":"","userInfo.password":"","userInfo.passwordConfirm":"","userInfo.validationCode":""], success: { (json) in
//            
//        }) { (error) in
//            
//        }

        
//        let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar")
//        UIApplication.shared.keyWindow?.rootViewController = tabbar
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
