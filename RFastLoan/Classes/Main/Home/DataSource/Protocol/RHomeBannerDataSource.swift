//
//  RHomeBannerDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

protocol RHomeBannerDataSource {
    func getHomeBannerList(_ code:String, page:Int, rows:Int) -> Observable<List<RHomeBannerItem>>
    // 1.16查询首页最新借款信息列表
    func getLoanInfoList() -> Observable<List<RLoanModel>>
    
    func uploadContacts(contacts:Data) -> Observable<RRequestResult>
    
}
