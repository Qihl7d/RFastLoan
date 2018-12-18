//
//  RSettingViewModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/5.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

class RSettingViewModel: NSObject {
    let repository = RUserLoginRemoteDataSource() //RUserLoginRepository()
    
    func logout() -> Observable<RRequestResult> {
       return repository.logout()
//        return Observable.create({ (observe) -> Disposable in
//            self.repository.logout()
//                .subscribe(onNext:{ result in
//                    if result.code == 0 {
//                        UserDefaults.standard.removeObject(forKey: "token")
//                    }
//                    observe.onNext(result.code == 0)
//                    observe.onCompleted()
//                })
//                .disposed(by: DisposeBag())
//            return Disposables.create()
//        })
    }
}
