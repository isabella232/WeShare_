//
//  CashSoSoHUD.swift
//  QianSoSo
//
//  Created by 顾玉玺 on 2017/8/15.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

import UIKit
import SnapKit

private let g_showNoticeOnStatusBar:Int = 10001
private let g_showActivityIndicatorView:Int = 10002
private let g_showNoticeWithTextTag:Int = 10003
private let g_showInputViewTag:Int = 10004

class SwiftNotice: NSObject {
    
    static let kWindows = UIApplication.shared.keyWindow
    static var timer: DispatchSource!
    static var timerTimes = 0
    static var delayTask: Task?
    static let sn = SwiftNotice()
    
    /// 顶部状态栏提示
    /// 如果有多个提示, 则依次按顺序提示
    /// - Parameters:
    ///   - text: 提示文字
    ///   - dismiss: 自动消失
    ///   - delayAfter: 自动消失的时间
    static func showNoticeOnStatusBar(text: String,dismiss: Bool = true,delayAfter:Int = 3){
        if let _ = kWindows?.viewWithTag(g_showNoticeOnStatusBar) {
            gf_Delay(TimeInterval(delayAfter), task: {
                showNoticeOnStatusBar(text: text, dismiss: true, delayAfter: delayAfter)
            })
            return
        }
        let bgView = UIView()
        bgView.tag = g_showNoticeOnStatusBar
        bgView.backgroundColor = UIColor.red
        kWindows?.addSubview(bgView)
        kWindows?.windowLevel = UIWindowLevelStatusBar

        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = text
        bgView.addSubview(label)
        
        let size = label.sizeThatFits(CGSize(width: KW-82, height: .greatestFiniteMagnitude))
        
        bgView.frame = CGRect(x: 0, y: 0, width: KW, height: size.height + 30)
        label.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        label.center = bgView.center

        bgView.transform = CGAffineTransform(translationX: 0, y: -size.height - 30)
        UIView.animate(withDuration: 0.3) {
            bgView.transform = .identity
        }
        
        if dismiss {
            hideNotice(bgView,delayAfter)
        }
    }
    static func hideActivityIndicatorView(_ view: UIView? = kWindows){
        if let v = view?.viewWithTag(g_showActivityIndicatorView) {
            v.removeFromSuperview()
        }
    }
    
    
    /// 活动指示器
    ///
    /// - Parameters:
    ///   - gif: 一组图片
    ///   - text: 文本
    ///   - view: 添加的父视图,默认添加在keywindow上面
    static func showActivityIndicatorView(gif: [UIImage] = [],text: String? = nil,in view: UIView? = nil){
        
        let clearColorView = UIView()
        clearColorView.tag = g_showActivityIndicatorView
        if let v = view {
            v.addSubview(clearColorView)
            clearColorView.frame = v.bounds
        }else{
            kWindows?.addSubview(clearColorView)
            clearColorView.frame = CGRect(x: 0, y: 0, width: KW, height: KH)
        }
        
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: 78, height: 78 )
        bgView.center = clearColorView.center
        bgView.layer.cornerRadius = 5
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        clearColorView.addSubview(bgView)
        
        if let t = text,t.count > 0 {
            let label = UILabel()
            label.text = text
            label.font = KMAIN_FONT(size: 13)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = UIColor.white
            bgView.addSubview(label)
            
            let size = label.sizeThatFits(CGSize(width: KW - 82, height: .greatestFiniteMagnitude))
            if size.width<38{
                bgView.bounds = CGRect(x: 0, y: 0, width: 78, height: 78 + size.height + 10)
                bgView.center = clearColorView.center
                label.frame = CGRect(x: (78-size.width)/2, y: 78, width: size.width, height: size.height)
            }else{
                bgView.bounds = CGRect(x: 0, y: 0, width: size.width+40, height: 78 + size.height + 10)
                bgView.center = clearColorView.center
                label.frame = CGRect(x: 20, y: 78, width: size.width, height: size.height)
            }
        }
        
        
        if gif.count > 0 {
             let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
            let imageView = UIImageView(frame: frame)
            imageView.image = gif.first
            imageView.contentMode = .scaleAspectFit
            bgView.addSubview(imageView)
            
            timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main) as! DispatchSource
            timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.milliseconds(0))
            timer.setEventHandler(handler: { () -> Void in
                let name = gif[timerTimes % gif.count]
                imageView.image = name
                timerTimes += 1
            })
            timer.resume()

        }else {
            let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            ai.frame = CGRect(x: (bgView.frame.width-36)/2, y: 21, width: 36, height: 36)
            ai.startAnimating()
            bgView.addSubview(ai)
        }
        
        bgView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            bgView.alpha = 1
        })

    }
    
    
    /// 文字提示
    /// 多个提示, 默认会取消前面的提示,提示当前的内容
    /// - Parameters:
    ///   - text: 提示文字
    ///   - dismiss: 自动消失
    ///   - delayAfter: 自动消失时间
    static func showNoticeWithText(text: String,dismiss: Bool = true,delayAfter:Int = 1){
        if let view = kWindows?.viewWithTag(g_showNoticeWithTextTag) {
            gf_Cancel(delayTask)
            let label = view.subviews.first as! UILabel
            label.text = text
            setFrame(label: label, bgView: view)
            hideNotice(view,delayAfter)
        }else{
            let bgView = UIView()
            bgView.layer.cornerRadius = 5
            bgView.alpha = 0
            bgView.tag = g_showNoticeWithTextTag
            bgView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            kWindows?.addSubview(bgView)

            let label = UILabel()
            label.text = text
            label.font = KMAIN_FONT(size: 13)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = UIColor.white
            bgView.addSubview(label)
            
            UIView.animate(withDuration: 0.3) {
                bgView.alpha = 1
            }
            
            setFrame(label: label, bgView: bgView)
            if dismiss {
                hideNotice(bgView,delayAfter)
            }
        }
    }
    
   static func setFrame(label: UILabel,bgView: UIView){
        let size = label.sizeThatFits(CGSize(width: KW-82, height: .greatestFiniteMagnitude))
        label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bgView.frame = CGRect(x: 0, y: 0, width: label.frame.width + 50, height: label.frame.height + 30)
        label.center = bgView.center
        bgView.center = (kWindows?.center)!    
    }
    
    static func showInputCodeView(finished Input:@escaping (PasswordView)->(Void),did changed:((PasswordView)->(Void))? = nil){
        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: KW, height: KH))
        maskView.tag = g_showInputViewTag
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        kWindows?.addSubview(maskView)
        
        let bgView = UIView()
        bgView.layer.cornerRadius = 5
        bgView.backgroundColor = UIColor.white
        maskView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(KSPACE)
            make.bottom.equalToSuperview().inset(240)
        }
        
        let cancle = UIButton(type: .custom)
        cancle.setImage(UIImage(named:"input_cancle"), for: .normal)
        cancle.addTarget(sn, action: #selector(clickedCancle), for: .touchUpInside)
        bgView.addSubview(cancle)
        cancle.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        let title = UILabel()
        title.text = "请输入交易密码"
        title.font = KMAIN_FONT(size: 15)
        bgView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(KSPACE)
        }
        
        let password = PasswordView()
        password.passwordFinishedInput = {passwordView in
            sn.clickedCancle()
            Input(passwordView)
        }
        password.passwordDidChangeInput = changed
        bgView.addSubview(password)
        password.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(KSPACE)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: KW-KSPACE*4, height: (KW-KSPACE*4)/6))
        }
        
        let forgetCode = UIButton(type: .system)
        forgetCode.titleLabel?.font = KMAIN_FONT(size: 14)
        forgetCode.setTitleColor(KMAIN_COLOR, for: .normal)
        forgetCode.setTitle("忘记密码?", for: .normal)
        forgetCode.addTarget(sn, action: #selector(click), for: .touchUpInside)
        bgView.addSubview(forgetCode)
        forgetCode.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(KSPACE)
        }
        
        let hint  = UILabel()
        hint.text = "友情提示: "
        hint.font = KMAIN_FONT(size: 14)
        hint.textColor = UIColor(hex: "f74c31")
        bgView.addSubview(hint)
        hint.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(KSPACE)
            make.top.equalTo(forgetCode.snp.bottom).offset(4)
        }
        
        let alipay = "1.钱嗖嗖官方唯一支付宝:"
        let web = " zhifubao@cashsoso.com"
        let bank = "2.钱嗖嗖官方唯一银行账户:"
        let bankId = " 7559 3318 4410 104"
        let msg = alipay+web+"\n"+bank+bankId
        let str = NSMutableAttributedString(string:msg)
        str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hex: "666666"), range: NSRange(location: 0, length: alipay.count))
        str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hex: "666666"), range: NSRange(location: alipay.count+web.count, length: bank.count))
        str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hex: "f74c31"), range: NSRange(location: alipay.count, length: web.count))
        str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hex: "f74c31"), range: NSRange(location: alipay.count+web.count+bank.count+1, length: bankId.count))

        
        let msgLabel = UILabel()
        msgLabel.attributedText = str
        msgLabel.font = KMAIN_FONT(size: 12)
        msgLabel.numberOfLines = 0
        bgView.addSubview(msgLabel)
        msgLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(KSPACE)
            make.top.equalTo(hint.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(KSPACE)
        }
        
}
    
    @objc func click(){
        print("忘记密码")
    }
    
    @objc func clickedCancle(){
        if let v = UIApplication.shared.keyWindow?.viewWithTag(g_showInputViewTag){
            UIView.animate(withDuration: 0.3, animations: {
                v.alpha = 0
                v.subviews.first?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            }, completion: { (finish) in
                v.removeFromSuperview()
            })
        }
    }

    
    static func hideNotice(_ sender: UIView,_ delayAfter: Int){
        delayTask = gf_Delay(TimeInterval(delayAfter), task: {
            UIView.animate(withDuration: 0.3, animations: {
                if sender.tag == g_showNoticeOnStatusBar {
                    sender.transform = CGAffineTransform(translationX: 0, y: -UIApplication.shared.statusBarFrame.height)
                }
                sender.alpha = 0
            }) { (finish) in
                if sender.tag == g_showNoticeOnStatusBar {
                    kWindows?.windowLevel = UIWindowLevelNormal
                }
                sender.removeFromSuperview()
            }
        })
    }
    
    
    
    
}


class PasswordView: UIView,UIKeyInput,UITextInputTraits {
    
    var hasText: Bool{
        return textStore.count>0 ? true : false
    }
    var isSecureTextEntry: Bool = true
    var passwordLength = 6{
        didSet{
            squareWidth = (KW-KSPACE*4)/CGFloat(passwordLength)
        }
    }
    var squareWidth = (KW-KSPACE*4)/6
    var textStore = String()
    
    override var canBecomeFirstResponder: Bool {
        get{
            return true
        }
    }
    
    var passwordDidChangeInput: ((PasswordView)-> Void)?
    var passwordFinishedInput: ((PasswordView)-> Void)?

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = KMAIN_COLOR.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        backgroundColor = UIColor.white
        becomeFirstResponder()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertText(_ text: String) {
        if textStore.count<passwordLength {
            textStore.append(text)
            if let block = passwordDidChangeInput{block(self)}
            if let block = passwordFinishedInput,textStore.count == passwordLength{block(self)}

            self.setNeedsDisplay()
        }
    }
    
    func deleteBackward() {
        if textStore.count>0 {
            textStore.removeLast()
            if let block = passwordDidChangeInput{block(self)}
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let height = rect.height
        let width = rect.width
        let x = (width - squareWidth*CGFloat(passwordLength))/2.0
        let y = (height - squareWidth)/2.0
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setStrokeColor(UIColor(hex: "f2f2f2").cgColor)
        ctx?.setFillColor(UIColor.white.cgColor)
        for i in 0...passwordLength {
            ctx?.move(to: CGPoint(x: x+CGFloat(i)*squareWidth, y: y))
            ctx?.addLine(to: CGPoint(x: x+CGFloat(i)*squareWidth, y: y+squareWidth))
            ctx?.closePath()
        }
        ctx?.drawPath(using: .fillStroke)
        ctx?.setFillColor(UIColor.black.cgColor)
        for i in 0...textStore.count {
            ctx?.addArc(center: CGPoint(x:x+CGFloat(i)*squareWidth - squareWidth/2.0,y:y+squareWidth/2), radius: 6, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
            ctx?.drawPath(using: .fill)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isFirstResponder {becomeFirstResponder()}
    }
    
}


