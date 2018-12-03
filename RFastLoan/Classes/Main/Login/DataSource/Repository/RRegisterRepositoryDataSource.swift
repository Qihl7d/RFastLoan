//
//  RRegisterRepositoryDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RRegisterRepositoryDataSource: RRegisterDataSource {
    private var local = RRegisterLocalDataSource()
    private var remote = RRegisterRemoteDataSource()
    func userRegister(userName: String, password: String) -> Observable<RRequestResult> {
        return Observable.concat(
            local.userRegister(userName:userName, password:password),
            remote.userRegister(userName:userName, password:password)
        )
    }
}
