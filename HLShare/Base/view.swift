//
//  view.swift
//  LuCommandLine
//
//  Created by Brave Lu on 2018/1/1.
//  Copyright © 2018年 Brave Lu. All rights reserved.
//

import Foundation

/**
* 操作视图
* @param <R> 回应的数据类型
* @author BraveLu
*/
class OpView<R> : PListener {
	func onResponse(_ response : R ,  _ querier : Querier<R>?) -> Void {
		show(response , querier)
	}
	func onError(_ error : Int, _ msg : String , _ querier : Querier<R>?) -> Void {
		print("通讯出错啦！error=\(error),msg=\(msg)");
	}
	func show(_ response : R , _ querier : Querier<R>?) {
		print("〖\(operationName)〗操作成功！操作结果：\(response)");
	}
	/** 操作名称 */
	var operationName : String = ""
}

/**
* 操作视图
* @param <R> 回应的数据类型
* @author BraveLu
*/
class OpViewEx<R> : PListener {
	func onResponse(_ response : R , _ querier : Querier<R>?) -> Void {
		show(response , querier)
	}
	func onError(_ error : Int, _ msg : String ,  _ querier : Querier<R>?) -> Void {
		print("通讯出错啦！error=\(error),msg=\(msg)");
	}
	func show(_ response : R , _ querier : Querier<R>?) {
		print("〖\(querier!.name)\(operationName)〗操作成功！操作结果：\(response)");
	}
	/** 操作名称 */
	var operationName : String {return ""}
}
