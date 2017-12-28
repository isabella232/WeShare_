//
//  CashSoSoPrefix.swift
//  QianSoSo
//
//  Created by 顾玉玺 on 2017/7/25.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

import Foundation
import Hue // 颜色库
import SnapKit // 自动布局
import SwiftyJSON
import HandyJSON


// 屏幕宽、高、状态栏高度
let KW = UIScreen.main.bounds.width
let KH = UIScreen.main.bounds.height
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.height
let KSCALE_HEIGHT = KH/568
let KSCALE_WIDTH  = KW/320
let KSPACE: CGFloat = UIDevice.current.model.contains("plus") ? 20 : 15

func ADAPTOR_HEIGHT(imageName:String,space:CGFloat = 0)->CGFloat{
    let height = UIImage(named: imageName)?.size.height
    let scale = (KW - space*2)/(320-space*2)
    return height!*scale
}
func ADAPTOR_HEIGHT(height:CGFloat,space:CGFloat = 0)->CGFloat{
    let scale = (KW - space*2)/(320-space*2)
    return height*scale
}
//4s 320*480
//5s 320*568
//6 375*667
//6s 414*736

// 字体
func KMAIN_FONT(name: String = "PingFangSC-Regular" ,size: CGFloat)->UIFont{
    if #available(iOS 9, *){
        return UIFont(name: name, size: size)!
    }
    return UIFont.systemFont(ofSize: size)
}

// 颜色
let KMAIN_COLOR = UIColor(hex: "0e93e9")
func RGB(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


// 延时调用
typealias Task = (_ cancel : Bool) -> Void
@discardableResult
func gf_Delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task?{
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

func gf_Cancel(_ task: Task?) {
    task?(true)
}



// 验证码倒计时
func g_verifyCode_timerSource(sender: UIButton,sceneId: String,mobile: String,interval: Int = 60)  {
//    HLNetworkManager.POST(url: "", param: ["si":"01_0006","sceneId":sceneId,"mobile":mobile], success: { (data) in
//        var timeCount = interval
//        let timer = DispatchSource.makeTimerSource( queue:  DispatchQueue.global())
//        timer.schedule(deadline: .now(), repeating: .seconds(1))
//        timer.setEventHandler {
//            timeCount = timeCount - 1
//            if timeCount <= 0 {
//                timer.cancel()
//                DispatchQueue.main.async {
//                    sender.setTitle("获取验证码", for: .normal)
//                    sender.isEnabled = true
//                }
//            }else{
//                let text = "\(timeCount % 60)" + "s"
//                DispatchQueue.main.async {
//                    UIView.beginAnimations("", context: nil)
//                    UIView.setAnimationDuration(1.0)
//                    sender.setTitle(text, for: .normal)
//                    UIView.commitAnimations()
//                    sender.isEnabled = false
//                }
//            }
//        }
//        timer.resume()
//    }, failure: { (error) in
//        //SwiftNotice.showNoticeWithText(text: error)
//    })
}



func g_DrawGradientImage(width: CGFloat,height: CGFloat) ->UIImage{
    UIGraphicsBeginImageContext(CGSize(width: width, height: height))
    let context = UIGraphicsGetCurrentContext()
    // 抠图
//    context?.setFillColor(UIColor.gray.cgColor)
//    context?.fill(view.bounds)
//    context?.clear(bgImageView.frame)
    
    // 绘制渐变图
    let colorSpace = CGColorSpaceCreateDeviceRGB()// rgb 颜色空间
    let compoents = [UIColor(hex: "02aaff").cgColor,UIColor(hex: "0386FF").cgColor]
    let locations: [CGFloat] = [0,1]
    let gradient = CGGradient(colorsSpace: colorSpace, colors: compoents as CFArray, locations: locations)
    let start = CGPoint(x: 0, y: 0)
    let end = CGPoint(x: width, y: height)
    context?.drawLinearGradient(gradient!, start: start, end: end, options: .drawsBeforeStartLocation)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!

}

func gradientShadowButton(type: UIButtonType = .system,frame: CGRect,title: String) -> UIButton{
    let button = UIButton(type: type)
    button.frame = frame
    //button.layer.cornerRadius = frame.height/2
    button.layer.shadowOffset = CGSize(width: 3, height: 5)
    button.layer.shadowRadius = 5
    button.layer.shadowColor = UIColor(hex: "028bff").cgColor
    button.layer.shadowOpacity = 0.48
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = KMAIN_FONT(size: 15)
    
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    gradientLayer.cornerRadius = frame.height/2
    gradientLayer.colors = [UIColor(hex: "02aaff").cgColor,UIColor(hex: "0386FF").cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    button.layer.insertSublayer(gradientLayer, at: 0)
    return button
    
}

func print<N>(msg:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEVELOPMENT
        print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息: \(msg)");
    #endif
}

func isBlank(_ text: String?) -> Bool {
    if let str = text {
        if !str.isEmpty {
            return false
        }
    }
    return true
}

// 判读真机/模拟器
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}


