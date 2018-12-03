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
        static var kFontColorKey : String = "kFontColorKey"
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
    
    var kTitleFontColor : UIColor {
        get {
            guard let theName = objc_getAssociatedObject(self, &kNavigationColorKey.kFontColorKey) as? UIColor else {
                return UIColor.white
            }
            return theName
        }
        set {
            objc_setAssociatedObject(self, &kNavigationColorKey.kFontColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    
    func setNavigationColor() {
        self.view.backgroundColor = UIColor.white
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
        UIGraphicsBeginImageContext(CGSize.init(width: kScreenWidth, height: kNavigationBarAndStatusHeight))
        image.draw(in: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarAndStatusHeight))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        let attributes = NSMutableDictionary()
        attributes[NSAttributedString.Key.foregroundColor] = kTitleFontColor
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
        navigationController?.navigationBar.titleTextAttributes = attributes as? [NSAttributedString.Key : Any]
    }
}


extension UIViewController {
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
}
