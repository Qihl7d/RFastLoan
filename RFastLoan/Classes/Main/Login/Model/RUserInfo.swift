//
//  RUserInfo.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm


class RUserInfo: Object, Mappable {
    @objc dynamic var member: RMemberInfo?
    @objc dynamic var token: String?
    @objc dynamic var userSig: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        member <- map["member"]
        token <- map["token"]
        userSig <- map["userSig"]
    }
    

}

class RMemberInfo :Object, Mappable {
    @objc dynamic var marriageStatus: String?
    @objc dynamic var addressBookStatus: String?
    @objc dynamic var id: String?
    @objc dynamic var idcardImg03: String?
    @objc dynamic var education: String?
    @objc dynamic var remark: String?
    @objc dynamic var jobName: String?
    @objc dynamic var contactTel: String?
    @objc dynamic var address: String?
    @objc dynamic var credit: String?
    @objc dynamic var idcardImg02: String?
    @objc dynamic var shi: String?
    @objc dynamic var promoteCode: String?
    @objc dynamic var tel: String?
    @objc dynamic var xian: String?
    @objc dynamic var updateDate: String?
    @objc dynamic var idcardImg01: String?
    @objc dynamic var recommendCode: String?
    @objc dynamic var sex: String?
    @objc dynamic var idcard: String?
    @objc dynamic var heardImg: String?
    @objc dynamic var salt: String?
    @objc dynamic var birthday: String?
    @objc dynamic var name: String?
    @objc dynamic var code: String?
    @objc dynamic var status: String?
    @objc dynamic var phoneCode: String?
    @objc dynamic var createDate: String?
    @objc dynamic var workYears: String?
    @objc dynamic var wechatCode: String?
    @objc dynamic var qqcode: String?
    @objc dynamic var balance: String?
    @objc dynamic var beginDate: String?
    @objc dynamic var password: String?
    @objc dynamic var sheng: String?
    @objc dynamic var contactName: String?
    @objc dynamic var contactNexus: String?
    @objc dynamic var endDate: String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        marriageStatus <- map["marriageStatus"]
        addressBookStatus <- map["addressBookStatus"]
        id <- map["id"]
        idcardImg03 <- map["idcardImg03"]
        education <- map["education"]
        remark <- map["remark"]
        jobName <- map["jobName"]
        contactTel <- map["contactTel"]
        address <- map["address"]
        credit <- map["credit"]
        idcardImg02 <- map["idcardImg02"]
        shi <- map["shi"]
        promoteCode <- map["promoteCode"]
        tel <- map["tel"]
        xian <- map["xian"]
        updateDate <- map["updateDate"]
        idcardImg01 <- map["idcardImg01"]
        recommendCode <- map["recommendCode"]
        sex <- map["sex"]
        idcard <- map["idcard"]
        heardImg <- map["heardImg"]
        salt <- map["salt"]
        birthday <- map["birthday"]
        name <- map["name"]
        code <- map["code"]
        status <- map["status"]
        phoneCode <- map["phoneCode"]
        createDate <- map["createDate"]
        workYears <- map["workYears"]
        wechatCode <- map["wechatCode"]
        qqcode <- map["qqcode"]
        balance <- map["balance"]
        beginDate <- map["beginDate"]
        password <- map["password"]
        sheng <- map["sheng"]
        contactName <- map["contactName"]
        contactNexus <- map["contactNexus"]
        endDate <- map["endDate"]
    }
}


