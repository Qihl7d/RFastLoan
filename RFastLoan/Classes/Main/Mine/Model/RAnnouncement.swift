//
//  RAnnouncement.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/7.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm


class RAnnouncement: Object, Mappable {
    @objc dynamic var id:String?
    @objc dynamic var collection: Int = 0
    @objc dynamic var content:String?
    @objc dynamic var coverImageUrl:String?
    @objc dynamic var resource:String?
    @objc dynamic var thumbsup: Int = 0
    @objc dynamic var createDate:String?
    @objc dynamic var topFlag: Int = 0
    @objc dynamic var updateUserId:String?
    @objc dynamic var url:String?
    @objc dynamic var addUserId:String?
    @objc dynamic var title:String?
    @objc dynamic var orderNo: Int = 0
    @objc dynamic var summary:String?
    @objc dynamic var updateDate:String?
    @objc dynamic var browserCount: Int = 0
    @objc dynamic var rzmoney: Int = 0
    @objc dynamic var status:String?
    @objc dynamic var articleGenreId:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
         id <- map["id"]
         collection <- (map["collection"], stringToInt())
         content <- map["content"]
         coverImageUrl <- map["coverImageUrl"]
         resource <- map["resource"]
         thumbsup <- (map["collection"], stringToInt())
         createDate <- map["createDate"]
         topFlag <- (map["collection"], stringToInt())
         updateUserId <- map["updateUserId"]
         url <- map["url"]
         addUserId <- map["addUserId"]
         title <- map["title"]
         orderNo <- (map["collection"], stringToInt())
         summary <- map["summary"]
         updateDate <- map["updateDate"]
         browserCount <- (map["collection"], stringToInt())
         rzmoney <- (map["collection"], stringToInt())
         status <- map["status"]
         articleGenreId <- map["articleGenreId"]
    }

}
