//
//  RHomeBannerItem.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RHomeBannerItem: Object, Mappable {
    
    @objc dynamic var coverImageUrl: String?
    @objc dynamic var updateUserId: String?
    @objc dynamic var status: String?
    @objc dynamic var title: String?
    @objc dynamic var url: String?
    @objc dynamic var summary: String?
    @objc dynamic var addUserId: String?
    @objc dynamic var thumbsup: Int = 0
    @objc dynamic var updateDate: String?
    @objc dynamic var code: String?
    @objc dynamic var rzmoney: Int = 0
    @objc dynamic var articleGenreName: String?
    @objc dynamic var topFlag: Int = 0
    @objc dynamic var browserCount: Int = 0
    @objc dynamic var endDate: String?
    @objc dynamic var articleGenreId: String?
    @objc dynamic var readeStatus: String?
    @objc dynamic var id: String?
    @objc dynamic var orderNo: String?
    @objc dynamic var createDate: String?
    @objc dynamic var beginDate: String?
    @objc dynamic var resource: String?
    @objc dynamic var memberId: String?
    @objc dynamic var content: String?
    @objc dynamic var collection: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        coverImageUrl <- map["coverImageUrl"]
        updateUserId <- map["updateUserId"]
        status <- map["status"]
        title <- map["title"]
        url <- map["url"]
        summary <- map["summary"]
        addUserId <- map["addUserId"]
        thumbsup <- (map["thumbsup"], stringToInt())
        updateDate <- map["updateDate"]
        code <- map["code"]
        rzmoney <- (map["rzmoney"], stringToInt())
        articleGenreName <- map["articleGenreName"]
        topFlag <- (map["topFlag"], stringToInt())
        browserCount <- (map["browserCount"], stringToInt())
        endDate <- map["endDate"]
        articleGenreId <- map["articleGenreId"]
        readeStatus <- map["readeStatus"]
        id <- map["id"]
        orderNo <- map["orderNo"]
        createDate <- map["createDate"]
        beginDate <- map["beginDate"]
        resource <- map["resource"]
        memberId <- map["memberId"]
        content <- map["content"]
        collection <- (map["collection"], stringToBool())
    }
}
