//
//  RAccessToken.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift

class RAccessToken: NSObject {
    /// 用户登录后的token
    ///
    /// - Returns: 返回缓存的token
    class func userAccessToken() -> String {
        
        return UserDefaults.standard.object(forKey: "token") as? String ?? ""
    }
    
    class func userPhone() -> String {
        return UserDefaults.standard.object(forKey: "userPhone") as? String ?? ""
    }
    
    class func userName() -> String {
        return UserDefaults.standard.object(forKey: "userName") as? String ?? ""
    }
}
