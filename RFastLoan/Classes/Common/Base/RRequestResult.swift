//
//  RRequestResult.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/2.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RRequestResult: Object, Mappable {
    var code : Int = 0
    var msg : String = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
    }
}

class RRequestResultObject<T:Object & Mappable>: Object, Mappable {
    var code : Int?
    var msg : String = ""
    var data : T?
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["message"]
        data <- map["data"]
    }
}

class RRequestResultList<T:Object & Mappable>: Object, Mappable {
    var code : Int = 0
    var msg : String = ""
    var data : List<T>?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        if (map["data"].currentValue != nil) {
            data <- (map["data"], ListTransform<T>())
        }
        
    }
}

