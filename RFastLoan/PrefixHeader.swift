//
//  PrefixHeader.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/31.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Realm
import RxRealm
import Foundation
import RealmSwift


//MARK: - 系统高度
let kScreenWidth : CGFloat  = UIScreen.main.bounds.size.width
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height

// Tabbar height.
let kTabbarHeight : CGFloat                 = UIDevice.isIphoneXLater() ? 83.0 : 49.0
// status bar height.
let kStatusBarHeight : CGFloat              = UIDevice.isIphoneXLater() ? 44.0 : 20.0
// navigationBar height
let kNavigationBarHeight : CGFloat          = 44.0
// Tabbar safe bottom margin.
let kTabbarSafeBottomMargin : CGFloat       = UIDevice.isIphoneXLater() ? 34.0 : 0.0
// navigationBar and Status Height
let kNavigationBarAndStatusHeight : CGFloat = UIDevice.isIphoneXLater() ? 88.0 : 64.0

// 线宽或高
let lineHeight = 0.7
let indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)

let secretKey = "*&x2xzn12jsdF`XS12seNsa#Xal$s82sa234*%@!)a-=/-1azc12aaAL4JDXSFSA"

let realmKey : Data = secretKey.data(using: String.Encoding.utf8)!

//    存在用户信息
let accountRealm = URL(fileURLWithPath: RLMRealmPathForFile("account.realm"), isDirectory: false)

//    存在应用数据
let modelsRealm = URL(fileURLWithPath: RLMRealmPathForFile("modes.realm"), isDirectory: false)

let accountConfig = Realm.Configuration.init(fileURL:accountRealm , inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: realmKey, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
//MARK: - 请求部分
let hostUrl = URL.init(string: "http://dk.shoux.net:9999/")!
let downloadImageUrl = "http://dk.shoux.net:9999/download"
// 请求成功时，返回结果
let requestSuccess = 0

//MARK: - 常用颜色
let hexColor666      = UIColor.hexInt(0x666666)
let hexColor333      = UIColor.hexInt(0x333333)
let hexColor999      = UIColor.hexInt(0x999999)
let lineColor        = UIColor.hexInt(0xCCCCCC)
let themeColor       = UIColor.hexInt(0x4DB4FF)
let RbackgroundColor = UIColor.hexInt(0xF0F2F5)

let navigationColor = UIColor.hexInt(0x4DB4FF)

func scale(_ origin:CGFloat) -> CGFloat {
    return origin * (min(kScreenWidth, kScreenHeight)/375.0)
}

func systemFont(_ ofSize:CGFloat) -> UIFont {
    return UIFont.systemFontWithScale(ofSize: ofSize)
}

func boldSystemFont(_ ofSize:CGFloat) -> UIFont {
    return UIFont.boldSystemFontWithScale(ofSize:ofSize)
}

func judgingNull(_ value:String?) -> String {
    if value == nil {
        return ""
    }
    return value!
}
