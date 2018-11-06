//
//  String+Height.swift
//  RIntegrity
//
//  Created by RPK on 2018/10/14.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

extension String {
        
    func getLabHeigh(font:UIFont, width:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = self as NSString
        
        let size = CGSize.init(width: width, height: 1000)
        
        let dic = NSDictionary.init(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.height
        
    }
    
    
    
    func getLabWidth(font:UIFont, height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = self as NSString
        
        let size = CGSize.init(width: 900, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.width
        
    }
}
