//
//  RMineViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class RMineViewModel: NSObject {
    let repository = RMineRepositoryDataSource()
    func getUserInfo() -> Observable<RMemberInfo> {
        return repository.getUserInfo()
    }
    
    func getCommonProblem(code: String, page: Int, pageSize: Int) -> Observable<List<RCommonProblem>> {
        return repository.getCommonProblem(code:code, page:page, pageSize:pageSize)
    }
    
    func getAnnouncement(code: String, readeStatus: Int) -> Observable<List<RAnnouncement>> {
        return repository.getAnnouncement(code: code, readeStatus: readeStatus)
    }
    
    func getBillingList(status: Int) -> Observable<List<RBillingItem>> {
        return repository.getBillingList(status:status)
    }
    
    func getAboutUs() -> Observable<RRequestResult> {
        return repository.getAboutUs()
    }
    
    func getLoanList(status: Int) -> Observable<List<RLoanItem>> {
        return repository.getLoanList(status: status)
    }
    
    func commitProfileInfo(userInfo: Dictionary<String, String>) -> Observable<RRequestResult> {
        return repository.commitProfileInfo(userInfo:userInfo)
    }
}
