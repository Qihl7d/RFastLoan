//
//  RHomeBannerRemoteDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RealmSwift

enum RHomeBannerApi {
    case getHomeBannerList(_ code: String, page: Int, rows: Int)
    case getLoanInfoList()
    case uploadContacts(contacts:Data)
}

extension RHomeBannerApi : TargetType {
    var baseURL: URL {
        return hostUrl
    }
    
    var path: String {
        switch self {
        case .getHomeBannerList(_, _, _):
            return "loanManage/api/article/v1/findArticleLimtList"
        case .getLoanInfoList():
            return "loanManage/api/loan/v1/findLoanListIndex"
        case .uploadContacts(_):
            return "loanManage/api/userTel/v1/uploadUserTel"
        default:
            break;
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
        case .getHomeBannerList(let code, let page, let rows):
            return .requestParameters(parameters: ["code":code, "page":"\(page)", "rows":"\(rows)"], encoding: URLEncoding.httpBody)
        case .getLoanInfoList():
            return .requestPlain
        case .uploadContacts(let contacts):
//            return .uploadMultipart([MultipartFormData.init(provider: MultipartFormData.FormDataProvider.data(contacts), name: "")])
            return .requestCompositeData(bodyData: contacts, urlParameters: ["":""])
        default:
            break;
        }
    }
    
    var headers: [String : String]? {
        let header = ["token":RAccessToken.userAccessToken()]
        return header
    }
    
}

class RHomeBannerRemoteDataSource: RHomeBannerDataSource {
    let provider = MoyaProvider<RHomeBannerApi>.init()
    func getHomeBannerList(_ code: String, page: Int, rows: Int) -> Observable<List<RHomeBannerItem>> {
        return provider.rx.request(.getHomeBannerList(code, page: page, rows: rows))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RHomeBannerItem>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func getLoanInfoList() -> Observable<List<RLoanModel>> {
        return provider.rx.request(.getLoanInfoList())
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RLoanModel>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }

    func uploadContacts(contacts:Data) -> Observable<RRequestResult> {
        return provider.rx.request(.uploadContacts(contacts: contacts))
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
