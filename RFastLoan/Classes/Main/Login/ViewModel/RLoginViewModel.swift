
//
//  RLoginViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/3.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RLoginViewModel: NSObject {
    let disposeBag = DisposeBag()
    func userLogin(_ userName:String,_ password:String) -> Observable<RUserInfo> {
        let repository = RUserLoginRepository()
        return repository.userLogin(userPhone: userName, password: password)
    }
    
    func changePassword(oldPsw: String, newPsw: String) -> Observable<RMemberInfo> {
        let repository = RChangePasswordRepositoryDataSource()
        return repository.changePassword(oldPsw:oldPsw, newPsw:newPsw)
    }
    
    func userRegister(userPhone: String, authCode: String, password: String) -> Observable<RRequestResult> {
        let repository = RUserLoginRepository()
        return repository.userRegister(userPhone:userPhone, authCode:authCode, password:password)
    }
    
}
