//
//  config.swift
//  LuCommandLine
//
//  Created by Brave Lu on 2018/1/1.
//  Copyright © 2018年 Brave Lu. All rights reserved.
//

import Foundation

class Config {
	
    static let BASE_URL = "http://192.168.1.113:8090/"

	static var token : String?
	
	static func getToken() -> String? {
        if let t = UserDefaults.standard.value(forKey: "token"){
            token = t as? String
        }
		return token
	}
	
	static func saveToken(_ token : String) {
		self.token = token
		UserDefaults.standard.set(token, forKey: "token")
	}
	
	
}
