//
//  LessorDemandController.swift
//  HLShare
//
//  Created by 顾玉玺 on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit


class BuyerDemandListController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  

//    var presenter = DemandListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
