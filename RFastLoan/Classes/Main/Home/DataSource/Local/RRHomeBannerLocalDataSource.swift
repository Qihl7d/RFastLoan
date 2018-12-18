//
//  RRHomeBannerLocalDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class RRHomeBannerLocalDataSource: RHomeBannerDataSource {
    func getHomeBannerList(_ code: String, page: Int, rows: Int) -> Observable<List<RHomeBannerItem>> {
        return Observable.empty()
    }
    
    func getLoanInfoList() -> Observable<List<RLoanModel>> {
        return Observable.empty()
    }
    
    func uploadContacts(contacts:Data) -> Observable<RRequestResult> {
        return Observable.empty()
    }
}
