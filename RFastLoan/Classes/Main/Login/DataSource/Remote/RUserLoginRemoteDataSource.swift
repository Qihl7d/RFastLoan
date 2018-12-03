//
//  RUserLoginRemoteDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import SVProgressHUD

enum  RUserLoginApi {
    case login(username:String, password:String)
}

extension RUserLoginApi : TargetType {
   
    var baseURL: URL {
        return hostUrl
    }

    var path: String {
        switch self {
        case .login(_, _):
            return "login"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["code":username, "passowrd":password], encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

class RUserLoginRemoteDataSource: RUserLoginDataSource {

    let provider = MoyaProvider<RUserLoginApi>.init()
    func userLogin(userPhone: String, password: String) -> Observable<RUserInfo> {
        
        return provider.rx.request(.login(username: userPhone, password: password))
            .debug()
            .asObservable()
            .mapObject(RRequestResultObject<RUserInfo>.self)
            .filter({ (httpResult) -> Bool in
//                dump(httpResult)
//                BAProgressHUD.dismiss()
                if httpResult.code == 200 {
//                    BAProgressHUD.showSuccess("登录成功")
                }
                else {
//                    BAProgressHUD.showError(httpResult.msg)
                }
                return httpResult.code == 200
            })
            .map({ (httpResult) in
                dump(httpResult.data)
                return httpResult.data!
            })
    }

    
    func updateUserInfo(userInfo: RUserInfo) -> Observable<RUserInfo> {
        return Observable.empty()
    }
}
