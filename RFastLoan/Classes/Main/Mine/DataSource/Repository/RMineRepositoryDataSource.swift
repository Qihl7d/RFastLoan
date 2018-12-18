//
//  RMineRepositoryDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class RMineRepositoryDataSource: RMineDataSource {
    let remote = RMineRemotoDataSource()
    func getUserInfo() -> Observable<RMemberInfo> {
        return Observable.concat(
            remote.getUserInfo()
        )
    }
    
    func getCommonProblem(code: String, page: Int, pageSize: Int) -> Observable<List<RCommonProblem>> {
        return Observable.concat(
            remote.getCommonProblem(code:code, page:page, pageSize:pageSize)
        )
    }
    
    func getAnnouncement(code: String, readeStatus: Int) -> Observable<List<RAnnouncement>> {
        return Observable.concat(
            remote.getAnnouncement(code:code, readeStatus:readeStatus)
        )
    }
    
    func getBillingList(status: Int) -> Observable<List<RBillingItem>> {
        return Observable.concat(
            remote.getBillingList(status:status)
        )
    }
    
    func getLoanList(status: Int) -> Observable<List<RLoanItem>> {
        return Observable.concat(
            remote.getLoanList(status:status)
        )
    }
    
    func getAboutUs() -> Observable<RRequestResult> {
        return Observable.concat(
            remote.getAboutUs()
        )
    }
    
    func commitProfileInfo(userInfo: Dictionary<String, String>) -> Observable<RRequestResult> {
        return Observable.concat(
            remote.commitProfileInfo(userInfo:userInfo)
        )
    }
}
