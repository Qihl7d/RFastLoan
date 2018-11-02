//
//  RTabBar.swift
//  RFastLoan
//
//  Created by RPK on 2018/10/30.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RTabBar: UITabBar {

    var centerBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        centerBtn.setImage(R.image.首页借款(), for: .normal)
        centerBtn.bounds = .init(x: 0, y: 0, width: 64, height: 64)
        self.addSubview(centerBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerBtn.center = CGPoint.init(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.3);
        var index : CGFloat = 0
        let width = self.bounds.size.width / 3
        for sub in self.subviews {
            if sub.isKind(of: (NSClassFromString("UITabBarButton"))!) {
                sub.frame = CGRect.init(x: index * width, y: self.bounds.origin.y, width: width, height: self.bounds.size.height - 2)
                index += 1
                if Int(index) == 1 {
                    index += 1
                }
            }
        }
        
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden == false {
            let newPoint = self.convert(point, to: self.centerBtn)
            if self.centerBtn.point(inside: newPoint, with: event) {
                return self.centerBtn
            }
            else {
                return super.hitTest(point, with: event)
            }
        }
        else {
            return super.hitTest(point, with: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
