//
//  MoyaProvider+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/13.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit
import Moya

extension MoyaProvider {
    convenience init() {
        #if DEBUG
            self.init(plugins:[NetworkLoggerPlugin()])
        #else
            self.init(plugins:[NetworkLoggerPlugin()])
            //self.init(plugins:[AccessTokenPlugin(tokenClosure: BATool.userAccessToken())])
        #endif
    }
}
