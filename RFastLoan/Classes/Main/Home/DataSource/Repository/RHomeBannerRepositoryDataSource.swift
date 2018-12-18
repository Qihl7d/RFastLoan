//
//  RHomeBannerRepositoryDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class RHomeBannerRepositoryDataSource: RHomeBannerDataSource {
    let remote = RHomeBannerRemoteDataSource()
    func getHomeBannerList(_ code: String, page: Int, rows: Int) -> Observable<List<RHomeBannerItem>> {
        return Observable.concat(
            remote.getHomeBannerList(code, page: page, rows: rows)
        )
    }
    
    func getLoanInfoList() -> Observable<List<RLoanModel>> {
        return Observable.concat(
            remote.getLoanInfoList()
        )
    }
    
    func uploadContacts(contacts:Data) -> Observable<RRequestResult> {
        return Observable.concat(
            remote.uploadContacts(contacts:contacts)
        )
    }
    
}
