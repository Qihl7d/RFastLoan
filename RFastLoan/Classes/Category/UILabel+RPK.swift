
//
//  UILabel+RPK.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/13.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

extension UILabel {
    func rpk_textWith() -> CGFloat {
        var stringWidth = CGFloat(0)
        if (text?.count ?? 0 > 0) {
            stringWidth = self.textRect(forBounds: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 30), limitedToNumberOfLines: 1).size.width
        }
        return stringWidth;
    }
}
