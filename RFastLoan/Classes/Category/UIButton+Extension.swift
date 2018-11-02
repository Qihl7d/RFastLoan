//
//  UIButton+Extension.swift
//  RIntegrity
//
//  Created by RPK on 2018/9/13.
//  Copyright © 2018年 RPK. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UIButton {

    var rx_buttonEnable : AnyObserver<Bool> {
        return Binder.init(self, binding: { (button, bool) in
            self.isEnabled = bool
            if bool {
                self.backgroundColor = .green
            }
            else {
                self.backgroundColor = .lightGray
            }
        }).asObserver()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
