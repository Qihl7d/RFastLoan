//
//  RChangePasswordDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/10.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxSwift


enum RChangePasswordApi {
    case changePassword(oldPsw:String, newPsw:String)
}

extension RChangePasswordApi : TargetType {
    var baseURL: URL {
        return hostUrl
    }
    
    var path: String {
        return "loanManage/api/member/v1/updatePass"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .changePassword(let oldPsw, let newPsw):
            return .requestParameters(parameters: ["oldPass":oldPsw, "newPass":newPsw], encoding: URLEncoding.httpBody)
        default:
            break
        }
    }
    
    var headers: [String : String]? {
        return ["token":RAccessToken.userAccessToken()]
    }
}

class RChangePasswordRemoteDataSource: RChangePasswordDataSource {
    private let provider = MoyaProvider<RChangePasswordApi>.init()
    func changePassword(oldPsw: String, newPsw: String) -> Observable<RMemberInfo>{
        return provider.rx.request(.changePassword(oldPsw: oldPsw, newPsw: newPsw))
            .debug()
            .asObservable()
            .mapObject(RRequestResultObject<RMemberInfo>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpReuslt) in
                return httpReuslt.data!
            })
    }
}
