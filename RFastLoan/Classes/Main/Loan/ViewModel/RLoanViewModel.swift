//
//  RLoanViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift


class RLoanViewModel: NSObject {
    let repository = RLoanTypeRepositoryDataSource()
    func getLoanTypeList(code: String) -> Observable<List<RLoanType>> {
        return repository.getLoanTypeList(code: code)
    }
    
    func commitLoanInfo(loanPurpose: String, cost: String, remark: String, paths: String) -> Observable<RRequestResult> {
        return repository.commitLoanInfo(loanPurpose:loanPurpose, cost:cost, remark:remark, paths:paths)
    }
    
    func uploadImage(imageData:Data) -> Observable<RRequestResult> {
        return repository.uploadImage(imageData:imageData)
    }
    
}
