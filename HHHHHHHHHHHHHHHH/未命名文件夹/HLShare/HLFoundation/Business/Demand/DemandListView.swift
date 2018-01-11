//
//  DemandView.swift
//  HLShare
//
//  Created by Brave Lu on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class DemandListView : ComboView<Result, ListLeaseDemandsResult, Result> {
	
	override func createComboPresenter() -> ComboPresenter<Result,ListLeaseDemandsResult> {
		return DemandComboPresenter()
	};
	//func getDemandComboPresenter() -> DemandComboPresenter {return comboPresenter as! DemandComboPresenter}
	
	override func showList(_ response: ListLeaseDemandsResult) {
		print("display demands here!!!!! error=\(response.error)")
	}
	
	/** callback for common operations */
	override func onOperated<T>(_ response: T, _ querier: Querier<T>?) {
		switch querier!.operation {
//		case Business.OP_FAVOR:
//			print("评价评价评价评价评价评价评价评价评价评价评价评价 OK")
		default:
			super.onOperated(response, querier)
		}
	}
	
}
