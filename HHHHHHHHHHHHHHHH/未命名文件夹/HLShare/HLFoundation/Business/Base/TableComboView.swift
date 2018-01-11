//
//  TableComboView.swift
//  HLShare
//
//  Created by Brave Lu on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

/**
* 包含列表控件的组合视图
* @param <DVO> 实体类型
* @param <E> 实体/元素操作返回类型
* @param <L> 列表操作返回类型
* @param <I> input操作返回类型
* @author BraveLu
*/
class TableComboView<DVO : Dvo, E, L : ListResult<DVO>, I> : ComboView<E, L, I>, UITableViewDataSource, UITableViewDelegate, PEntityOperator {
	
	/** 列表控件。子类必须提供。 */
	var tableView : UITableView? {return nil}
	/** 执行列表操作后，从服务器取回的实体列表 */
	var entityList : L? = nil
	/** cell标识。由子类提供。 */
	var cellIdentifier : String {return ""}
	
	/** 列表操作回调处理 */
	override func showList(_ response: L) {
		entityList = response
		tableView?.reloadData()
		//super.showList(response)
	}

//Implements UITableViewDataSource, UITableViewDelegate
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let list = entityList {
			return list.getEntities!.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: /*"homeCell"*/cellIdentifier, for: indexPath) as! TableComboViewCell<DVO>
		//cell.delegate = self
		cell.entityOperator = self
		if let list = entityList {
			cell.entity = list.getEntities![indexPath.row]
		}		
		return cell
	}
	
//Implements POperateEntity
	
	/** 针对实体执行指定操作 */
	func operateEntity(_ operation: Int, _ entity: Any) -> Bool {
		// 按以下顺序尝试执行：自身，组内的Operation操作，组内的普通操作
		let dvo = entity as! DVO
		if let _id = dvo.id {id = _id}
		if !selfExecute(operation) {
			if !operate(operation) { return execute(operation)}
		}
		return true
	}
	
//其他iOS特定
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView!.rowHeight = 300
		onCmdList()
	}
	
}
