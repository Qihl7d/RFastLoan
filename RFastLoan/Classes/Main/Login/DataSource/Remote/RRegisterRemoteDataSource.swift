//
//  RRegisterRemoteDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import SVProgressHUD

enum  RUserRegisterApi {
    case register(username:String, password:String)
}

extension RUserRegisterApi : TargetType {
    
    var baseURL: URL {
        return hostUrl
    }
    
    var path: String {
        switch self {
        case .register(_, _):
            return "register"
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
        case .register(let username, let password):
            return .requestParameters(parameters: ["code":username, "passowrd":password], encoding: URLEncoding.httpBody)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

class RRegisterRemoteDataSource: RRegisterDataSource {
    let provider = MoyaProvider<RUserRegisterApi>.init()
    func userRegister(userName: String, password: String) -> Observable<RRequestResult> {
        
        return provider.rx.request(.register(username: userName, password: password))
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
            .filter({ (httpResult) -> Bool in
                dump(httpResult)
                BAProgressHUD.dismiss()
                if httpResult.code == 200 {
                    BAProgressHUD.ba_showWithStatus("登录成功")
                }
                else {
                    BAProgressHUD.ba_showError(withStatus: httpResult.msg)
                }
                return httpResult.code == 200
            })
            .map({ (httpResult) in
                dump(httpResult)
                return httpResult
            })
    }
}
