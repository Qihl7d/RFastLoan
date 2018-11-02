
//
//  UIDevice+Extension.swift
//  RNessGoods
//
//  Created by RPK on 2018/10/25.
//  Copyright © 2018 RPK. All rights reserved.
//


import UIKit

extension UIDevice {
    // iPhone X设备
    class func isIphoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
    // iPhone X以上设备   iPhone XS / iPhone XS Max / iPhone XR
    class func isIphoneXLater() -> Bool {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!
            if (window?.safeAreaInsets.bottom)! > 0.0 {
                return true
            }
            else {
                return false
            }
        } else {
            return false
        }
    }
}
