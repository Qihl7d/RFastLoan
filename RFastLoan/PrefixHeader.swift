//
//  PrefixHeader.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/31.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit
import Foundation


//MARK: - 系统高度
let RscreenWidth : CGFloat  = UIScreen.main.bounds.size.width
let RscreenHeight : CGFloat = UIScreen.main.bounds.size.height

// Tabbar height.
let tabbarHeight : CGFloat                 = UIDevice.isIphoneXLater() ? 83.0 : 49.0
// status bar height.
let statusBarHeight : CGFloat              = UIDevice.isIphoneXLater() ? 44.0 : 20.0
// navigationBar height
let navigationBarHeight : CGFloat          = 44.0
// Tabbar safe bottom margin.
let tabbarSafeBottomMargin : CGFloat       = UIDevice.isIphoneXLater() ? 34.0 : 0.0
// navigationBar and Status Height
let navigationBarAndStatusHeight : CGFloat = UIDevice.isIphoneXLater() ? 88.0 : 64.0

// 线宽或高
let lineHeight = 0.7

//MARK: - 请求部分
let host = URL.init(string: "")
// 请求成功时，返回结果
let requestSuccess = 200

//MARK: - 常用颜色
let hexColor666     = UIColor.hexInt(0x28CDA6)
let hexColor333     = UIColor.hexInt(0x333333)
let hexColor999     = UIColor.hexInt(0x999999)
let lineColor       = UIColor.hexInt(0xCCCCCC)

let navigationColor = UIColor.hexInt(0x4DB4FF)

func scale(_ origin:CGFloat) -> CGFloat {
    return origin * (min(RscreenWidth, RscreenHeight)/375.0)
}

func systemFont(_ ofSize:CGFloat) -> UIFont {
    return UIFont.systemFontWithScale(ofSize: ofSize)
}
