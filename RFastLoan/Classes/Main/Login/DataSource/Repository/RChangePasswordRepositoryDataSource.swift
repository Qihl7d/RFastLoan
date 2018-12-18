//
//  RChangePasswordRepositoryDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/10.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RChangePasswordRepositoryDataSource: RChangePasswordDataSource {
    let remote = RChangePasswordRemoteDataSource()
    func changePassword(oldPsw: String, newPsw: String) -> Observable<RMemberInfo> {
        return Observable.concat(
            remote.changePassword(oldPsw: oldPsw, newPsw: newPsw)
        )
    }
}
