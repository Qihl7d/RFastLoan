//
//  RUserLoginLocalDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class RUserLoginLocalDataSource: RUserLoginDataSource {
    
    func userLogin(userPhone: String, password: String) -> Observable<RUserInfo> {
        return Observable.create({ (observe) -> Disposable in
            do {
                let realm = try Realm.init(configuration: accountConfig)
                let result = realm.objects(RUserInfo.self).first
                if result != nil {
                    let model = RUserInfo()
                    observe.onNext(model)
                }
            }
            catch let error {
                print(error)
            }
            observe.onCompleted()
            return Disposables.create()
        })
    }
    
    func updateUserInfo(userInfo: RUserInfo) -> Observable<RUserInfo> {
        return Observable.create({ (observable) -> Disposable in
            do {
                let realm = try Realm.init(configuration: accountConfig)
                let result = realm.objects(RUserInfo.self).first
                try! realm.write {
                    if result != nil {

                        observable.onNext(result!)
                    }
                    else {

                        realm.add(userInfo)
                        observable.onNext(userInfo)
                    }
                }
            }
            catch let error {
                print(error)
            }
            observable.onCompleted()
            return Disposables.create()
        })
    }
    
}
