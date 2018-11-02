//
//  Observable+ObjectMapper.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/13.
//  Copyright © 2018年 RPK. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import RealmSwift


extension Response {
    
    //    MARK:json转Model
    public func mapObject<T: Mappable>(_ type: T.Type) throws -> T {
        
        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}

extension ObservableType where E == Response {
    //    MARK:这个是将JSON解析为Observable类型的Model
    public func mapObject<T: Mappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            // Log.debug(response)
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    
}
