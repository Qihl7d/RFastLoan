//
//  ProviceCityList.swift
//  GreenAir
//
//  Created by BruceAlbert on 2017/12/13.
//  Copyright © 2017年 Mars. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class ProviceCityList : NSObject {
    var list:Array<ProviceListModel>?
}

class ProviceListModel: Mappable {
    @objc dynamic var name:String?
    var city : Array<CityListModel>?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name <- map["name"]
        city <- map["city"]
    }
}

class CityListModel : Mappable {
    @objc dynamic var name:String?
    var area : Array<String>?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name <- map["name"]
        area <- map["area"]
    }
}

