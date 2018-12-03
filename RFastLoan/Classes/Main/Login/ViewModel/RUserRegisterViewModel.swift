//
//  RUserRegisterViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RUserRegisterViewModel: NSObject {
    let disposeBag = DisposeBag()
    func userRegister(_ userName:String,_ password:String) -> Observable<RRequestResult> {
        let repository = RRegisterRemoteDataSource()
        return repository.userRegister(userName: userName, password: password)
    }
    
    //    MARK:发送验证码
    func sendVerificationCode(_ userPhone:String) -> Observable<(Bool, String)> {
        return Observable.create({ (observe) -> Disposable in
            let commonRequest = RCommonRequest()
            commonRequest.sendSmsCode(userPhone: userPhone)
                .subscribe(onNext: { (result) in
                    observe.onNext((result.code == 200, result.msg))
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        })
        
    }

}
