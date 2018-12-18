//
//  RUserLoginRepository.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RUserLoginRepository:RUserLoginDataSource {
    
    private var local = RUserLoginLocalDataSource()
    private var remote = RUserLoginRemoteDataSource()
    func userLogin(userPhone: String, password: String) -> Observable<RUserInfo> {
        return Observable.concat(
//            local.userLogin(userPhone:userPhone, password:password),
            remote.userLogin(userPhone:userPhone, password:password)
                .do(onNext: { (userInfo) in
                    self.local.updateUserInfo(userInfo: userInfo)
                        .subscribe()
                })
        )
    }
    
    func updateUserInfo(userInfo: RUserInfo) -> Observable<RUserInfo> {
        return Observable.empty()
    }
    
    func userRegister(userPhone: String, authCode: String, password: String) -> Observable<RRequestResult> {
        return remote.userRegister(userPhone:userPhone, authCode:authCode, password:password)
            .do()
    }
    
    func logout() -> Observable<RRequestResult> {
        return remote.logout()
    }
    
    func changePassword(oldPsw: String, newPsw: String) -> Observable<RMemberInfo> {
        return Observable.concat(
            remote.changePassword(oldPsw:oldPsw, newPsw:newPsw)
        )
    }
    
    func resetPassword(oldPsw: String, newPsw: String, phoneCode: String) -> Observable<RMemberInfo> {
        return Observable.concat(
            remote.resetPassword(oldPsw:oldPsw, newPsw:newPsw, phoneCode:phoneCode)
        )
    }
}
