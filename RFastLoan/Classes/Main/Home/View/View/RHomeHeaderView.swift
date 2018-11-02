//
//  RHomeHeaderView.swift
//  RFastLoan
//
//  Created by RPK on 2018/11/1.
//  Copyright © 2018 RPK. All rights reserved.
//

import UIKit

class RHomeHeaderView: UIView {

    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    private func initView() {
        
        backgroundColor = UIColor.hexInt(0xF0F2F5)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(160)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.width.greaterThanOrEqualTo(0)
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
