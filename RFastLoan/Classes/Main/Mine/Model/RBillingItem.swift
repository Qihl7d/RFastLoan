//
//  RBillingItem.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/16.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RBillingItem: Object, Mappable {
    var remark: String?
    var cost: String?
    var endDate: String?
    var id: String?
    var status: String?
    var updateDate: String?
    var loanPurpose: String?
    var code: String?
    var beginDate: String?
    var createDate: String?
    var memberId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        remark <- map["remark"]
        cost <- map["cost"]
        endDate <- map["endDate"]
        id <- map["id"]
        status <- map["status"]
        updateDate <- map["updateDate"]
        loanPurpose <- map["loanPurpose"]
        code <- map["code"]
        beginDate <- map["beginDate"]
        createDate <- map["createDate"]
        memberId <- map["memberId"]
    }
}
