//
//  RLoanRemoteDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Alamofire
import RealmSwift

enum RLoanApi {
    case getLoanType(code:String)
    case commitLoanInfo(loanPurpose:String, cost:String, remark:String, paths:String)
    case uploadImage(imageData:Data)
}

extension RLoanApi : TargetType {
    var baseURL: URL {
        return hostUrl
    }
    
    var path: String {
        switch self {
        case .getLoanType(_):
            return "loanManage/api/common/v1/findDictList"
        case .commitLoanInfo(_, _, _, _):
            return "loanManage/api/loan/v1/addLoanInfo"
        case .uploadImage(_):
            return "loanManage/api/common/v1/upload"
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
        case .getLoanType(let code):
            return .requestParameters(parameters: ["code":code], encoding: URLEncoding.httpBody)
        case .commitLoanInfo(let loanPurpose, let cost, let remark, let paths):
            let parameters = ["loanPurpose": loanPurpose, "cost":cost, "remark":remark, "paths":paths]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        case .uploadImage(let imageData):
//            let formData = MultipartFormData.init(provider: MultipartFormData.FormDataProvider.data(imageData), name: "uploadImg", fileName: "xxxx.jpg", mimeType: "image/png")
            let formData = MultipartFormData.init(provider: MultipartFormData.FormDataProvider.data(imageData), name: "uploadImg")
            return .uploadMultipart([formData])
        default:
            break
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImage(_):
            return nil
        default:
            return ["token":RAccessToken.userAccessToken()]
        }
    }
    
    
}

class RLoanRemoteDataSource: RLoanDataSource {
    let provider = MoyaProvider<RLoanApi>.init()
    func getLoanTypeList(code: String) -> Observable<List<RLoanType>> {
        return provider.rx.request(.getLoanType(code: code))
            .debug()
            .asObservable()
            .mapObject(RRequestResultList<RLoanType>.self)
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult.data!
            })
    }
    
    func commitLoanInfo(loanPurpose: String, cost: String, remark: String, paths: String) -> Observable<RRequestResult> {
        return provider.rx.request(.commitLoanInfo(loanPurpose: loanPurpose, cost: cost, remark: remark, paths: paths))
            .debug()
            .asObservable()
            .mapObject(RRequestResult.self)
            .filter({ (httpResult) -> Bool in
                if httpResult.code == requestSuccess {
                    BAProgressHUD.ba_showWithStatus("借款申请提交成功")
                }
                else {
                    BAProgressHUD.ba_showWithStatus("借款申请提交失败")
                }
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult
            })
    }
    
    func uploadImage(imageData: Data) -> Observable<RRequestResult> {
        return provider.rx.request(.uploadImage(imageData:imageData))
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
