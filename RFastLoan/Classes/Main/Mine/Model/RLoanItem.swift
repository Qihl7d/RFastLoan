//
//  RLoanItem.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/16.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RLoanItem: Object, Mappable {
    var status: String?
    var updateDate: String?
    var cost: String?
    var id: String?
    var code: String?
    var loanPurpose: String?
    var remark: String?
    var endDate: String?
    var beginDate: String?
    var createDate: String?
    var memberId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        updateDate <- map["updateDate"]
        cost <- map["cost"]
        id <- map["id"]
        code <- map["code"]
        loanPurpose <- map["loanPurpose"]
        remark <- map["remark"]
        endDate <- map["endDate"]
        beginDate <- map["beginDate"]
        createDate <- map["createDate"]
        memberId <- map["memberId"]
    }
}
