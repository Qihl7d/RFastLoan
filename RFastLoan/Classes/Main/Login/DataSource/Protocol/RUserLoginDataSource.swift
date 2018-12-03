//
//  UserLoginDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

protocol RUserLoginDataSource {
    func userLogin(userPhone:String, password:String) -> Observable<RUserInfo>;
    func updateUserInfo(userInfo:RUserInfo) -> Observable<RUserInfo>;
}


