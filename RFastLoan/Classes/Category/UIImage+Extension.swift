//
//  UIImage+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/12.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageWithColor(color:UIColor) -> UIImage {
        let imageW = 3
        let imageH = 3
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: imageW, height: imageH), false, 0.0);
        color.set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: imageW, height: imageH));
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
    
    func normalizedImage() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect.init(origin: CGPoint.zero, size: self.size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
