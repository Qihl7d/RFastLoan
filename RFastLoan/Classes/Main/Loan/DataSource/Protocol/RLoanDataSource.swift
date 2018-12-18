//
//  RLoanDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol RLoanDataSource {
    func getLoanTypeList(code:String) -> Observable<List<RLoanType>>
    func commitLoanInfo(loanPurpose:String, cost:String, remark:String, paths:String) -> Observable<RRequestResult>
    func uploadImage(imageData:Data) -> Observable<RRequestResult>
}
