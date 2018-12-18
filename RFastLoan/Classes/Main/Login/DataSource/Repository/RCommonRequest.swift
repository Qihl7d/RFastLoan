//
//  RCommonRequest.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

//import UIKit
import RxSwift
import Moya
import SVProgressHUD
import Alamofire

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
            // http://dk.shoux.net:9999/loanManage/api/common/v1/sendSms
            return "loanManage/api/common/v1/sendSms"
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
            .filter({ (httpResult) -> Bool in
                return httpResult.code == requestSuccess
            })
            .map({ (httpResult) in
                return httpResult
            })
    }
    
    /// 图片上传
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: 参数 ["token": "89757", "userid": "nb74110"]
    ///   - images: image数组
    ///   - success: 成功闭包
    ///   - failture: 失败闭包
    func upload(urlString : String, params:[String:String]?, imageData: Data, success: @escaping (_ response : Dictionary<String, String>) -> (), failture : @escaping (_ error : Error)->()) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            if params != nil {
                for (key, value) in params! {
                    //参数的上传
                    multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                }
            }
//            for (index, value) in images.enumerated() {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let str = formatter.string(from: Date())
                let fileName = str + ".jpg"
                
                // 以文件流格式上传
                // 批量上传与单张上传，后台语言为java或.net等
                multipartFormData.append(imageData, withName: "uploadImg", fileName: fileName, mimeType: "image/jpeg")
                // 单张上传，后台语言为PHP
//                multipartFormData.append(imageData, withName: "fileupload", fileName: fileName, mimeType: "image/jpeg")
                // 批量上传，后台语言为PHP。 注意：此处服务器需要知道，前台传入的是一个图片数组
//                multipartFormData.append(imageData, withName: "fileupload[\(index)]", fileName: fileName, mimeType: "image/jpeg")
            
        },
                         to: urlString,
                         headers: nil,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    print("response = \(response)")
                                    
                                    let result = response.result
                                    if result.isSuccess {
                                        let str = self.toolsChangeToJson(info: response.value)
                                        let nsdic = self.getDictionaryFromJSONString(jsonString: str)
                                        var dic = Dictionary<String, String>()
                                        for key in nsdic.allKeys {
                                            let keyl = "\(key)"
                                            dic[keyl] = "\(nsdic[key]!)"
                                        }
                                        BAProgressHUD.ba_showWithStatus(dic["message"])
                                        success(dic)
                                    }
                                }
                            case .failure(let encodingError):
                                failture(encodingError)
                            }
        }
        )
    }
    
    
    func userRegister(userPhone: String, authCode: String, password: String, success: @escaping (_ response : Dictionary<String, String>) -> (), failture : @escaping (_ error : Error)->()) {
        Alamofire.request("http://dk.shoux.net:9999/loanManage/api/member/v1/register", method: .post, parameters: ["code":userPhone, "phoneCode":authCode, "password":password], encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                let result = response.result
                if result.isSuccess {
                    let str = self.toolsChangeToJson(info: response.value)
                    let nsdic = self.getDictionaryFromJSONString(jsonString: str)
                    var dic = Dictionary<String, String>()
                    for key in nsdic.allKeys {
                        let keyl = "\(key)"
                        dic[keyl] = "\(nsdic[key]!)"
                    }
                    BAProgressHUD.ba_showWithStatus(dic["message"])
                    success(dic)
                }
                else {
                    BAProgressHUD.ba_showWithStatus("注册失败")
                }
        }
    }
    
    func toolsChangeToJson(info: Any) -> String{
        //首先判断能不能转换
        guard JSONSerialization.isValidJSONObject(info) else {
            print("json转换失败")
            return ""
        }
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let jsonData = try? JSONSerialization.data(withJSONObject: info, options: [])
        
        if let jsonData = jsonData {
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            return str ?? ""
        }else {
            return ""
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
}
