//
//  UIViewController+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/13.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private struct kNavigationColorKey {
        static var kNavigationKey: String = "kNavigationColorKey"
    }
    
    var kNavigationColor: UIColor {
        get {
            guard let theName = objc_getAssociatedObject(self, &kNavigationColorKey.kNavigationKey) as? UIColor else {
                return navigationColor
            }
            return theName
        }
        set {
            objc_setAssociatedObject(self, &kNavigationColorKey.kNavigationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func setNavigationColor() {
        //设置导航栏背景风格
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        //设置导航栏的半透明效果，默认是yes
        
        //        self.navigationController?.navigationBar.translucent = false
        
        //设置导航栏的背景颜色(必须有半透明效果)
        
        //        self.navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        
        //将导航上所有的Label的字体变色
        
//        self.navigationController?.navigationBar.tintColor = UIColor.red
        
        //设置图片作为导航栏的背景,设置了背景图片，导航栏就不透明
        
        var image = UIImage.imageWithColor(color: kNavigationColor)
        UIGraphicsBeginImageContext(CGSize.init(width: RscreenWidth, height: navigationBarAndStatusHeight))
        image.draw(in: CGRect.init(x: 0, y: 0, width: RscreenWidth, height: navigationBarAndStatusHeight))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
}
