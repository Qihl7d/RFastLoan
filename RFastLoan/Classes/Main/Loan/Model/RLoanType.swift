//
//  RLoanType.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/9.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RLoanType: Object, Mappable {
    @objc dynamic var code: String?
    @objc dynamic var id: String?
    @objc dynamic var value: String?
    @objc dynamic var orderNum: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var remark: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        id <- map["id"]
        value <- map["value"]
        orderNum <- (map["orderNum"], stringToInt())
        name <- map["name"]
        remark <- map["remark"]
    }
}
