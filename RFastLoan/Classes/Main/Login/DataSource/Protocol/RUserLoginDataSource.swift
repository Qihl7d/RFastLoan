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
    func userRegister(userPhone:String, authCode:String, password:String) -> Observable<RRequestResult>
    func userLogin(userPhone:String, password:String) -> Observable<RUserInfo>;
    func updateUserInfo(userInfo:RUserInfo) -> Observable<RUserInfo>;
    func logout() -> Observable<RRequestResult>
    func changePassword(oldPsw:String, newPsw:String) -> Observable<RMemberInfo>
    func resetPassword(oldPsw:String, newPsw:String, phoneCode:String) -> Observable<RMemberInfo>
}


