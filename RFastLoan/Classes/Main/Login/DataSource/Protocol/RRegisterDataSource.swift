
//
//  RRegisterDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

protocol RRegisterDataSource {
    func userRegister(userName:String, password:String) -> Observable<RRequestResult>
}
