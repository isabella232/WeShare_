//
//  File.swift
//  HLShare
//
//  Created by HLApple on 2018/1/11.
//  Copyright © 2018年 HLApple. All rights reserved.
//

import RxCocoa
import RxSwift

enum ValidationResult{
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}
extension ValidationResult{
    var isValid: Bool{
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
protocol WeShareAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func login(_ username: String, password: String) -> Observable<Bool>

}

protocol WeSharValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
}
