//
//  RChangePasswordDataSource.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/10.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift

protocol RChangePasswordDataSource {
    func changePassword(oldPsw:String, newPsw:String) -> Observable<RMemberInfo>
} 
