//
//  LoginViewController.swift
//  HLShare
//
//  Created by HLApple on 2017/12/22.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
// http://www.cocoachina.com/swift/20170222/18727.html

// http://www.cocoachina.com/swift/20170218/18729.html

//http://www.cocoachina.com/swift/20160930/17682.html
//https://www.jianshu.com/p/baea1ef1e4f5
//http://www.cocoachina.com/ios/20170907/20462.html
class LoginViewController: EntityView<LoginResult, LoginResult> {
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBOutlet weak var codeValidationLabel: UILabel!
    
    @IBOutlet weak var phoneNumValidationLabel: UILabel!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    var disposeBag = DisposeBag()
    
    var presenter = LoginPresenter()
    
    override var entityPresenter: EntityPresenter<LoginResult>? {return presenter as EntityPresenter<LoginResult>}
    
//    override func commonInit() {
//        super.commonInit()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.of(1,2,3,4,5).map({ num -> Int in
            return num*100
        }).subscribe {print("item: \($0)")}.disposed(by: disposeBag)
        
        let str = BehaviorSubject(value: "hello")
        str.subscribe { print("item: \($0)") }.disposed(by: disposeBag)
        str.onNext("world")
        
        let num = Variable(123)
        num.asObservable().subscribe { print("item: \($0)")  }.disposed(by: disposeBag)
        num.value = 12
        num.value = 111111
        
        print("----------------------------------------")
      
        
        let scott = Person(name: Variable("Scott"))
        let lori = Person(name: Variable("Lori"))
        let person = Variable(scott)
        person.asObservable().flatMap { p in
            return p.name.asObservable()
            }.subscribe { print("item: \($0)")  }.disposed(by: disposeBag)
        person.value = lori
        scott.name.value = "Eric"
        
        print("----------------------------------------")

       bingViewModel()
        
    }
    struct Person{
        var name: Variable<String>
    }
    
    func bingViewModel()  {
        
        viewModel = LoginViewModel(username:phoneNumTextField.rx.text.orEmpty.asObservable(),
                                   code:codeTextField.rx.text.orEmpty.asObservable(),
                                   tap:loginButton.rx.tap.asObservable())
        
        viewModel?.loginEnable.subscribe(onNext: { [weak self] (x) in
            self?.loginButton.isEnabled = x
        }).disposed(by: disposeBag)
       
//        viewModel?.login.subscribe(onNext: { [weak self] (x) in
//            if x{
//                print("-----------success-----------")
//            }else{
//                print("-----------failure-----------")
//            }
//
//        }).disposed(by: disposeBag)
       
        
        
        
    }
    
    
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
       // presenter.login("aaaaaa", "111111")
        //login method 2
        //execute()
    }
    
    
    override func onOperated<T>(_ response: T, _ querier: Querier<T>?) {
        UIApplication.shared.keyWindow?.rootViewController =  self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
