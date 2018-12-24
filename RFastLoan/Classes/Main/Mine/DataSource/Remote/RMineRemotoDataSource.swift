//
//  RMineRemotoDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RealmSwift

enum RMineApi {
    case userInfo()
    case commonProblem(code:String, page:Int, pageSize:Int)
    case announcement(code:String, readeStatus:Int)
    case getBillingList(status:Int)
    case getLoanList(status: Int)
    case getAboutUs()
    case commitProfileInfo(userInfo:Dictionary<String, String>)
    case getNewVersion()
}

extension RMineApi : TargetType {
    var baseURL: URL {
        return hostUrl
    }
    
    var path: String {
        switch self {
        case .userInfo():
            return "loanManage/api/member/v1/getMemberInfo"
        case .commonProblem(_, _, _):
            return "loanManage/api/article/v1/findArticleLimtList"
        case .announcement(_, _):
            return "loanManage/api/article/v1/findNoticeList"
        case .getBillingList(_):
            return "loanManage/api/loan/v1/findAdvanceInfoList"
        case .getLoanList(_):
            return "loanManage/api/loan/v1/findLoanList"
        case .getAboutUs():
            return "loanManage/api/article/v1/getArticleOne"
        case .commitProfileInfo(_):
            return "loanManage/api/member/v1/updateMember"
        case .getNewVersion():
            return "loanManage/api/common/v1/getLatestVersion"
        default:
            break
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
        case .userInfo():
            return .requestPlain
        case .commonProblem(let code, let page, let pageSize):
            return .requestParameters(parameters: ["code":code, "page":"\(page)", "rows":"\(pageSize)"], encoding: URLEncoding.httpBody)
        case .announcement(let code, let readeStatus):
            return .requestParameters(parameters: ["code":code, "readeStatus":"\(readeStatus)"], encoding: URLEncoding.httpBody)
        case .getBillingList(let status):
            return .requestParameters(parameters: ["status":"\(status)"], encoding: URLEncoding.httpBody)
        case .getLoanList(let status):
            return .requestParameters(parameters: ["status":"\(status)"], encoding: URLEncoding.httpBody)
        case .getAboutUs():
            return .requestParameters(parameters: ["code":"contactUs"], encoding: URLEncoding.httpBody)
        case .commitProfileInfo(let userInfo):
            return .requestParameters(parameters: userInfo, encoding: URLEncoding.httpBody)
        case .getNewVersion():
            return .requestParameters(parameters: ["system":"ios"], encoding: URLEncoding.httpBody)
        default:
            break
        }
    }
    
    var headers: [String : String]? {
        return ["token":RAccessToken.userAccessToken()]
    }
}

class RMineRemotoDataSource: RMineDataSource {
    let provider = MoyaProvider<RMineApi>.init()
    func getUserInfo() -> Observable<RMemberInfo> {
        return provider.rx.request(.userInfo())
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
    
    func getCommonProblem(code: String, page: Int, pageSize: Int) -> Observable<List<RCommonProblem>> {
        return provider.rx.request(.commonProblem(code: code, page: page, pageSize: pageSize))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RCommonProblem>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func getAnnouncement(code: String, readeStatus: Int) -> Observable<List<RAnnouncement>> {
        return provider.rx.request(.announcement(code: code, readeStatus: readeStatus))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RAnnouncement>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func getBillingList(status: Int) -> Observable<List<RBillingItem>> {
        return provider.rx.request(.getBillingList(status: status))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RBillingItem>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func getLoanList(status: Int) -> Observable<List<RLoanItem>> {
        return provider.rx.request(.getLoanList(status: status))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RLoanItem>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func getAboutUs() -> Observable<RRequestResult> {
        return provider.rx.request(.getAboutUs())
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
    
    func commitProfileInfo(userInfo: Dictionary<String, String>) -> Observable<RRequestResult> {
        return provider.rx.request(.commitProfileInfo(userInfo: userInfo))
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
            .filter({ (httpResult) -> Bool in
                if httpResult.code == requestSuccess {
                    BAProgressHUD.ba_showWithStatus("信息更新成功")
                }
                else {
                    BAProgressHUD.ba_showWithStatus(httpResult.msg)
                }
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult
            })
    }
    
    func getNewVersion() -> Observable<RRequestResult> {
        return provider.rx.request(.getNewVersion())
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
    
}
