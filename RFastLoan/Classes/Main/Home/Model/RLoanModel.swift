//
//  RLoanModel.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/8.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RLoanModel: Object, Mappable {

    @objc dynamic var id: String?
    @objc dynamic var loanPurpose: String?
    @objc dynamic var createDate: String?
    @objc dynamic var endDate: String?
    @objc dynamic var memberName: String?
    @objc dynamic var code: String?
    @objc dynamic var memberId: String?
    @objc dynamic var remark: String?
    @objc dynamic var updateDate: String?
    @objc dynamic var beginDate: String?
    @objc dynamic var status: String?
    @objc dynamic var cost: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        loanPurpose <- map["loanPurpose"]
        createDate <- map["createDate"]
        endDate <- map["endDate"]
        memberName <- map["memberName"]
        code <- map["code"]
        memberId <- map["memberId"]
        remark <- map["remark"]
        updateDate <- map["updateDate"]
        beginDate <- map["beginDate"]
        status <- map["status"]
        cost <- map["cost"]
    }
}
