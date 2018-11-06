//
//  RButton.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/4.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RButton: UIControl {

    let imageView  = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    private func initView() {
        
        self.addSubview(imageView)
        imageView.sizeToFit()
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-10)
            make.height.lessThanOrEqualTo(50)
            make.width.lessThanOrEqualTo(50)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = hexColor333
        titleLabel.font = systemFont(14)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalTo(2)
            make.right.equalTo(-2)
            make.height.equalTo(20)
        }
    }
    
    func setTitle(_ title:String) {
        titleLabel.text = title
    }
    
    func setImage(_ image:UIImage) {
        imageView.image = image
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
