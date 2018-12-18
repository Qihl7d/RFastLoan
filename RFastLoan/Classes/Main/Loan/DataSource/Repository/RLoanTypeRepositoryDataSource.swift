//
//  RLoanTypeRepositoryDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift


class RLoanTypeRepositoryDataSource: RLoanDataSource {
    let remote = RLoanRemoteDataSource()
    func getLoanTypeList(code: String) -> Observable<List<RLoanType>> {
        return Observable.concat(
            remote.getLoanTypeList(code:code)
        )
    }
    
    func commitLoanInfo(loanPurpose: String, cost: String, remark: String, paths: String) -> Observable<RRequestResult> {
        return Observable.concat(
            remote.commitLoanInfo(loanPurpose:loanPurpose, cost:cost, remark:remark, paths:paths)
        )
    }
    
    func uploadImage(imageData: Data) -> Observable<RRequestResult> {
        return Observable.concat(
            remote.uploadImage(imageData:imageData)
        )
    }
}
