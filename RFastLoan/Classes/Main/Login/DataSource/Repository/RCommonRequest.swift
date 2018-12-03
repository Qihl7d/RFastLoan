//
//  RCommonRequest.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SVProgressHUD

enum RCommonRequestApi {
    case sendSmsCode(userPhone:String)
}

extension RCommonRequestApi : TargetType {
    var baseURL: URL {
        return hostUrl
    }

    var path: String {
        switch self {
        case .sendSmsCode(_):
            return "loanMange/api/common/v1/sendSms"
        }
    }

    var method: Moya.Method {
        switch self {
        case .sendSmsCode(_):
            return .post
        }
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        case .sendSmsCode(let userPhone):
            return .requestParameters(parameters: ["mobile":userPhone], encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

class RCommonRequest:NSObject {
    #if DEBUG
    private let provider = MoyaProvider<RCommonRequestApi>(plugins:[NetworkLoggerPlugin()])
    #else
    private let provider = MoyaProvider<RCommonRequestApi>()
    #endif
    func sendSmsCode(userPhone:String) -> Observable<RRequestResult> {
        return provider.rx.request(.sendSmsCode(userPhone: userPhone))
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
    }
}
