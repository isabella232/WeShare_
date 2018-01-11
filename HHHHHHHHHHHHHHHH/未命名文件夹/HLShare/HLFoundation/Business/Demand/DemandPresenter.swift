//
//  DemandComboPresenter.swift
//  HLShare
//
//  Created by Brave Lu on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

class DemandComboPresenter : ComboPresenter<Result, ListLeaseDemandsResult> {
	
	//override var querier : Querier<ListLeaseDemandsResult>? {return DemandListNao.getListAsBuyerQuerier()}

}

/**
* 订单列表Presenter
* @author BraveLu
*/
class DemandListPresenter : ListPresenter<ListLeaseDemandsResult> {
	override init() {
		super.init()
		//nao = .obtainInstance()
	}
}
