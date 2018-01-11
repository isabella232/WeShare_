//
//  DemandNao.swift
//  HLShare
//
//  Created by Brave Lu on 2018/1/9.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import Foundation

/**
* Demand操作NAO
* @author BraveLu
*/
class DemandNao : BaseEntityNao<Result> {
	override init() {
		super.init()
		baseUrl = Config.BASE_URL+"lease/"
	}
	private static var INSTANCE = DemandNao()
	static func obtainOrderNaoInstance() -> DemandNao {return INSTANCE}
}

/**
* Demand列表操作NAO
* @author BraveLu
*/
class DemandListNao : BaseNao<ListLeaseDemandsResult> {
	override init() {
		super.init()
		baseUrl = Config.BASE_URL+"lease/"
	}
	override func parseJson(_ json: String) -> Any? {
		return ListLeaseDemandsResult.deserialize(from: json)
	}
	static var INSTANCE = DemandListNao()
	static func obtainInstance() -> DemandListNao {return INSTANCE}
	/** 作为买家的demand列表 */
	static func getListAsBuyerQuerier() -> Querier<ListLeaseDemandsResult> {
		// TODO
		var q = Querier<ListLeaseDemandsResult>("lessee/demand", nil, nil)
		q.params["state"] = 0
		return q
	}
	/** 作为卖家的demand列表 */
	static func getListAsVendorQuerier() -> Querier<ListLeaseDemandsResult> {
		// TODO
		return Querier<ListLeaseDemandsResult>("lessor/demand", nil, nil);
	}
}

