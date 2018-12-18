//
//  RHomeBannerViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class RHomeBannerViewModel: NSObject {
    let disposeBag = DisposeBag()
    let repository = RHomeBannerRepositoryDataSource()
    func getHomeBannerList(code:String, page:Int, pageSize:Int) -> Observable<List<RHomeBannerItem>> {
        return repository.getHomeBannerList(code, page:page, rows:pageSize)
        
    }
    
    func getLoanInfoList() -> Observable<List<RLoanModel>> {
        return repository.getLoanInfoList()
    }
    
    func uploadContacts(contacts:Data) -> Observable<RRequestResult> {
        return repository.uploadContacts(contacts:contacts)
    }
}
