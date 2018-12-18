//
//  RCommonFuncation.swift
//  RFastLoan
//
//  Created by RPK on 2018/12/15.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RCommonFuncation: NSObject {
    //电话号码正则判断
    static func isTelNumber(num:NSString) -> Bool
    {
        let mobile = "^134[0-8]\\d{7}$|^13[^4]\\d{8}$|^14[5-9]\\d{8}$|^15[^4]\\d{8}$|^16[6]\\d{8}$|^17[0-8]\\d{8}$|^18[\\d]{9}$|^19[8,9]\\d{8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if (regextestmobile.evaluate(with: num) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
}
