//
//  TableComboViewCell.swift
//  HLShare
//
//  Created by Brave Lu on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import UIKit

/**
* 列表控件的Cell
* @param <E> 实体（列表元素）类型
* @author BraveLu
*/
class TableComboViewCell<E : Dvo> : UITableViewCell {
	/** 处理实体的委托 */
	var entityOperator : PEntityOperator? = nil
	/** Cell关联的实体对象。由调用者进行设置。子类须重写。 */
	var entity : E? {
		get {return nil}
		set {}
	}
	/** 针对关联的实体对象，执行指定操作。实际操作将交给委托执行。 */
	func doOperate(_ operation : Int) {
		if entity != nil {entityOperator?.operateEntity(operation, entity!)}
	}
	//各项基本操作
	func onClickDetails() {doOperate(Business.OP_DETAILS)}
	func onClickInput() {doOperate(Business.OP_INPUT)}
	func onClickDelete() {doOperate(Business.OP_DELETE)}
	func onClickCancel() {doOperate(Business.OP_CANCEL)}
	func onClickEdit() {doOperate(Business.OP_MODIFY)}
	func onClickReview() {doOperate(Business.OP_REVIEW)}
	func onClickReviewUi() {doOperate(Business.OP_REVIEW|Business.OP_UI)}
}

/** 实体操作器 */
protocol PEntityOperator {
	/** 针对指定实体，执行指定操作
	 * @return 是否已执行
	*/
	func operateEntity(_ operation : Int, _ entity : Any) -> Bool
}
