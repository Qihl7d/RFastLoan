//
//  UIFont+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func sysFont12() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 12)
    }
    
    class func sysFont13() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 13)
    }
    
    class func sysFont14() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 14)
    }
    
    class func sysFont15() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 15)
    }
    
    class func sysFont16() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 16)
    }
    
    class func titleFont() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 18)
    }
    
    class func normalFont() -> UIFont {
        return UIFont.systemFontWithScale(ofSize: 16)
    }
    
    open class func systemFontWithScale(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: scale(fontSize))
    }
    

}
