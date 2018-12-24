
//
//  RMineDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/6.
//  Copyright © 2018 RPK. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol RMineDataSource {
    func getUserInfo() -> Observable<RMemberInfo>
    func getCommonProblem(code:String, page:Int, pageSize:Int) -> Observable<List<RCommonProblem>>
    func getAnnouncement(code:String, readeStatus:Int) -> Observable<List<RAnnouncement>>
    func getBillingList(status:Int) -> Observable<List<RBillingItem>>
    func getLoanList(status:Int) -> Observable<List<RLoanItem>>
    func getAboutUs() -> Observable<RRequestResult>
    func commitProfileInfo(userInfo:Dictionary<String, String>) -> Observable<RRequestResult>
    func getNewVersion() -> Observable<RRequestResult>
}
