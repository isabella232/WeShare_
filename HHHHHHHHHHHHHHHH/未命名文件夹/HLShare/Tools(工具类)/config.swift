//
//  config.swift
//  LuCommandLine
//
//  Created by Brave Lu on 2018/1/1.
//  Copyright © 2018年 Brave Lu. All rights reserved.
//

import Foundation

class Config {
    
    #if DEVELOPMENT
    // 测试环境
    static let BASE_URL = "http://47.100.14.37:8080/"
    //    static let BASE_URL = "http://192.168.1.113:8090/"
    let BMK_SERVICES_API_KEY = "测试"
    let HYPHENATELITE_API_KEY = "aa1c2e092bdd44cfc02b1d80d52869ac"
    #else
    // 开发环境
    static let BASE_URL = "http://47.100.14.37:8080/"
    //    static let BASE_URL = "http://192.168.1.113:8090/"
    let BMK_SERVICES_API_KEY = "开发"
    let HYPHENATELITE_API_KEY = "aa1c2e092bdd44cfc02b1d80d52869ac"
    
    #endif
	
	static var token : String = "12345678"
	
	static func getToken() -> String {
		if let t = UserDefaults.standard.value(forKey: "token") {token = t as! String}
		else {token = ""}
		return token
	}
	
	static func saveToken(_ token : String) {
		//self.token = "12333333"
		self.token = token
		UserDefaults.standard.set(token, forKey: "token")
	}
	

}
