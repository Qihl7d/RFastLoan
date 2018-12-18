//
//  RCommonCategory.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import ObjectMapper
import SVProgressHUD

func stringToFloat() -> TransformOf<Float, String> {
    return TransformOf<Float, String>(fromJSON: { (value: String?) -> Float? in
        // transform value from String? to Float?
        return Float(value!)
    }, toJSON: { (value: Float?) -> String? in
        // transform value from Float? to String?
        if let value = value {
            return String(value)
        }
        return nil
    })
}

func stringToDouble() -> TransformOf<Double, String> {
    return TransformOf<Double, String>(fromJSON: { (value: String?) -> Double? in
        return Double(value!)
    }, toJSON: { (value: Double?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })
}

func stringToInt() -> TransformOf<Int, String> {
    return TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        if value != nil {
            return Int(value!)
        }
        else {
            return 0
        }
    }, toJSON: { (value: Int?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })
}

func stringToInt32() -> TransformOf<Int32, String> {
    return TransformOf<Int32, String>(fromJSON: { (value: String?) -> Int32? in
        if value != nil {
            return Int32(value!)
        }
        else {
            return 0
        }
    }, toJSON: { (value: Int32?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })
}

func stringToBool() -> TransformOf<Bool, String> {
    return TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
        return value == "1" ? true : false
    }, toJSON: { (value: Bool?) -> String? in
        if let value = value {
            return value ? "1" : "0"
        }
        return nil
    })
}

func stringTo<T>() -> TransformOf<T, String> {
    return TransformOf<T, String>(fromJSON: { (value: String?) -> T? in
        if value != nil {
            return value! as? T
        }
        else {
            return 0 as? T
        }
    }, toJSON: { (value: T?) -> String? in
        if let value = value {
            return String(describing: value)
        }
        return nil
    })
}

