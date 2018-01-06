//
//  ActionSheet.swift
//  QianSoSo
//
//  Created by 顾玉玺 on 2017/8/17.
//  Copyright © 2017年 顾玉玺. All rights reserved.
//

import UIKit
import Foundation
class ActionSheet: UIView,UITableViewDelegate,UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    typealias comfirmedBlock = (Int,String)->()
    typealias cancleBlock = ()->()
    typealias dismissFinishedBlock = ()->()
    
    private var finished: comfirmedBlock?
    private var cancel: cancleBlock?
    private var dataSource: [String]?
    

    var textColor = UIColor.black
    var cancleColor = UIColor.red
    var shade = UIView() //遮罩
    var titleFont = UIFont.systemFont(ofSize: 14)
    
    
    class func show(hint: String? = nil,msgs: [String],finished: @escaping comfirmedBlock,cancle:cancleBlock? = nil)
    {
        if ((UIApplication.shared.keyWindow?.viewWithTag(10001)) != nil) {
            return
        }
        let act = ActionSheet(frame:CGRect(x: 0, y: 0, width: KW, height: KH),hint:hint,msgs:msgs)
        act.tag = 10001
        act.finished = finished
        act.cancel = cancle
        UIApplication.shared.keyWindow?.addSubview(act)
        act.layoutIfNeeded()
        act.transform = CGAffineTransform(translationX: 0, y: (act.viewWithTag(103)?.frame.height)!)
        UIView.animate(withDuration: 0.3) {
            act.transform = CGAffineTransform.identity
        }
    }
    @objc func dismiss(tap: UIGestureRecognizer) {
        let act = UIApplication.shared.keyWindow?.viewWithTag(10001) as? ActionSheet
        if let view = act {
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform(translationX: 0, y: (view.viewWithTag(103)?.frame.height)!)
                view.shade.alpha = 0
            }, completion: { (fnished) in
                view.removeFromSuperview()
            })
        }
    }
    
    func dismiss(animated: Bool = true,completion: @escaping dismissFinishedBlock){
        let act = UIApplication.shared.keyWindow?.viewWithTag(10001) as? ActionSheet
        if let view = act {
            if animated{
                UIView.animate(withDuration: 0.3, animations: {
                    view.transform = CGAffineTransform(translationX: 0, y: (view.viewWithTag(103)?.frame.height)!)
                    view.shade.alpha = 0
                }, completion: { (fnished) in
                    view.removeFromSuperview()
                    completion()
                })
            }else{
                view.removeFromSuperview()
                
                completion()
            }
        }

    }
    
    
    init(frame: CGRect,hint: String? = nil,msgs: [String]) {
        super.init(frame: frame)
        
        let titleView = UIView()
        titleView.backgroundColor = UIColor.white.alpha(0.8)
        addSubview(titleView)

        let title = UILabel()
        title.text = hint
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = UIColor.gray
        title.font = titleFont
        titleView.addSubview(title)
        
        dataSource = msgs

        shade.backgroundColor = UIColor.black.alpha(0.5)
        shade.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(tap:))))
        addSubview(shade)
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        addSubview(tableView)
       
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.tag = 103
        insertSubview(effectView, at: 0)
        
        effectView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.top)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
        title.snp.makeConstraints { (make) in
            if !isBlank(hint){
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            }else{
                make.edges.equalToSuperview()
            }
        }
        tableView.snp.makeConstraints {(make) in
            make.left.right.bottom.equalToSuperview()
            var  textH = title.sizeThatFits(CGSize(width: KW - 80, height: KH)).height
            if textH == 0{textH +=  40}
            let h1 = (msgs.count + 1) * 44 + 10
            let h = CGFloat(h1) + textH
            if h > KH - 40{
                make.height.equalTo(KH - 40 - textH)
                tableView.isScrollEnabled = true
            }else{
                make.height.equalTo(msgs.count * 44 + 10 + 44)
                tableView.isScrollEnabled = false
            }
        }
        shade.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(KH)
            make.bottom.equalTo(titleView.snp.top)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return (dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.textAlignment = .center
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell?.backgroundColor = UIColor.white.alpha(0.5)
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = dataSource?[indexPath.row]
            cell?.textLabel?.textColor = textColor
        }else{
            cell?.textLabel?.text = "取消"
            cell?.textLabel?.textColor = cancleColor
        }
        return cell!
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0{
            self.dismiss( completion: {[unowned self] in
                self.finished!(indexPath.row,self.dataSource![indexPath.row])
            })
        }else{
            self.dismiss( completion: {[unowned self] in
                self.cancel!()
            })
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmpty(str: String?) ->Bool{
        if let newStr = str {
            if newStr.lengthOfBytes(using:  .utf8)>0 {
                return false
            }
        }else{
            return true
        }
        
        return true
    }


}
