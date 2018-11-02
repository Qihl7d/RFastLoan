//
//  UILabel+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/16.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit

extension UILabel {

    private func rpk_textSize(width: CGFloat, height: CGFloat) -> CGSize {
        if text != nil && text?.count != 0 {
            let strSize = text?.boundingRect(with: CGSize(width: width, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font], context: nil).size
            return strSize!
        }
        
        if attributedText != nil {
            let strSize = attributedText!.boundingRect(with: CGSize(width: width, height: height), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
    }
    
    func rpk_textHeight(width: CGFloat) -> CGFloat {
        return ceil(rpk_textSize(width: width, height: CGFloat.greatestFiniteMagnitude).height)
    }
    
    
    func rpk_textWith(height: CGFloat) -> CGFloat {
        return ceil(rpk_textSize(width: CGFloat.greatestFiniteMagnitude, height: height).width)
    }
    
    // 富文本高度
    func rpk_AttrHeight(width: CGFloat) -> CGFloat {
        return ceil(rpk_textSize(width: width, height: CGFloat.greatestFiniteMagnitude).height)
    }
    
    // 富文本宽
    func rpk_AttrWidth(height: CGFloat) -> CGFloat {
        return ceil(rpk_textSize(width: CGFloat.greatestFiniteMagnitude, height: height).width)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
