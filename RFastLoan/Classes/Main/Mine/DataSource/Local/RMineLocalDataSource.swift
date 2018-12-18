//
//  RMineLocalDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class RMineLocalDataSource: RMineDataSource {
    func getUserInfo() -> Observable<RMemberInfo> {
        return Observable.empty()
    }
    
    func getCommonProblem(code: String, page: Int, pageSize: Int) -> Observable<List<RCommonProblem>> {
        return Observable.empty()
    }

    func getAnnouncement(code: String, readeStatus: Int) -> Observable<List<RAnnouncement>> {
        return Observable.empty()
    }
    
    func getBillingList(status: Int) -> Observable<List<RBillingItem>> {
        return Observable.empty()
    }
    
    func getLoanList(status: Int) -> Observable<List<RLoanItem>> {
        return Observable.empty()
    }
    
    func getAboutUs() -> Observable<RRequestResult> {
        return Observable.empty()
    }
    
    func commitProfileInfo(userInfo: Dictionary<String, String>) -> Observable<RRequestResult> {
        return Observable.empty()
    }
}
