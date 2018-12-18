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
    case register(username:String, code:String, password:String)
    case login(username:String, password:String)
    case logout()
    case changePassword(oldPsw:String, newPsw:String)
    case resetPassword(oldPsw:String, newPsw:String, phoneCode:String)
}

extension RUserLoginApi : TargetType {
   
    var baseURL: URL {
        return hostUrl
    }

    var path: String {
        switch self {
        case .register(_, _, _):
            return "loanManage/api/member/v1/register"
        case .login(_, _):
            return "loanManage/api/member/v1/login"
        case .logout():
            return "loanManage/api/member/v1/loginOut"
        case .changePassword(_, _):
            return "loanManage/api/member/v1/updatePass"
        case .resetPassword(_, _, _):
            return "loanManage/api/member/v1/resetPass"
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
        case .register(let username, let code, let password):
            return .requestParameters(parameters: ["code":username, "phoneCode":code, "password":password], encoding: URLEncoding.httpBody)
        case .login(let username, let password):
            return .requestParameters(parameters: ["code":username, "password":password], encoding: URLEncoding.httpBody)
        case .logout():
            return .requestPlain
        case .changePassword(let oldPsw, let newPsw):
            return .requestParameters(parameters: ["oldPass":oldPsw, "newPass":newPsw], encoding: URLEncoding.httpBody)
        case .resetPassword(let oldPsw, let newPsw, let phoneCode):
            return .requestParameters(parameters: ["oldPass":oldPsw, "newPass":newPsw, "phoneCode":phoneCode], encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .logout():
            return ["token":RAccessToken.userAccessToken()]
        case .changePassword(_, _):
            return ["token":RAccessToken.userAccessToken()]
        case .register(_, _, _):
            return nil//["token":RAccessToken.userAccessToken()]
        default:
            return nil
        }
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
                dump(httpResult)
                if httpResult.code == 0 {
                    BAProgressHUD.ba_showWithStatus("登录成功")
                }
                else {
                    BAProgressHUD.ba_showError(withStatus: httpResult.msg)
                }
                return httpResult.code == 0
            })
            .map({ (httpResult) in
                dump(httpResult.data)
                return httpResult.data!
            })
    }

    
    func updateUserInfo(userInfo: RUserInfo) -> Observable<RUserInfo> {
        return Observable.empty()
    }
    
    func userRegister(userPhone:String, authCode:String, password:String) -> Observable<RRequestResult> {
        return provider.rx.request(.register(username: userPhone, code: authCode, password: password))
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult
            })
    }
    
    func logout() -> Observable<RRequestResult> {
        return provider.rx.request(.logout())
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult
            })
    }
    
    func changePassword(oldPsw: String, newPsw: String) -> Observable<RMemberInfo> {
        return provider.rx.request(.changePassword(oldPsw: oldPsw, newPsw: newPsw))
            .debug()
            .asObservable()
            .mapObject(RRequestResultObject<RMemberInfo>.self)
            .filter({ (httpResult) -> Bool in
                if httpResult.code == requestSuccess {
                    BAProgressHUD.ba_showWithStatus(httpResult.msg)
                }
                else {
                    BAProgressHUD.ba_showError(withStatus: httpResult.msg)
                }
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func resetPassword(oldPsw: String, newPsw: String, phoneCode: String) -> Observable<RMemberInfo> {
        return provider.rx.request(RUserLoginApi.resetPassword(oldPsw: oldPsw, newPsw: newPsw, phoneCode: phoneCode))
            .debug()
            .asObservable()
            .mapObject(RRequestResultObject<RMemberInfo>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
}
